#!/bin/bash
set -euo pipefail

# =====================================
# Appify Self-Updater
# =====================================
# Updates Appify itself from GitHub releases. Supports both AppImage and
# .deb installs. Run as root (via the appify-updater.service/.timer pair).

GITHUB_REPO="bobbycomet/Appify"
CONFIG_FILE="/etc/appify-updater.conf"
LOG_FILE="/var/log/appify-updater.log"
CACHE_DIR="/var/cache/appify-updater"
CACHE_FILE="$CACHE_DIR/last_check"

mkdir -p "$CACHE_DIR" 2>/dev/null || true

# Utility function for logging (stdout for the journal + a persistent logfile)
log() {
    local line
    line="[$(date '+%Y-%m-%d %H:%M:%S')] $*"
    echo "$line"
    echo "$line" >> "$LOG_FILE" 2>/dev/null || true
}

# Notification function (only if notify-send exists)
notify_user() {
    local message="$1"
    if command -v notify-send &>/dev/null; then
        for user_runtime in /run/user/*; do
            user_id=$(basename "$user_runtime")
            if [ -S "$user_runtime/bus" ]; then
                sudo -u "#$user_id" DBUS_SESSION_BUS_ADDRESS="unix:path=$user_runtime/bus" \
                    notify-send "Appify Updater" "$message" || true
            fi
        done
    else
        log "ℹ️ Notifications skipped (notify-send not installed)."
    fi
}

# Ensure required commands exist
for cmd in curl dpkg-query dpkg; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Error: Required command '$cmd' not found."
        exit 1
    fi
done

# =====================================
# Load / bootstrap config
# =====================================
# CONFIG_FILE format:
#   INSTALL_TYPE=appimage|deb
#   APPIMAGE_PATH=/full/path/to/Appify.AppImage   (only used if INSTALL_TYPE=appimage)
#   DEB_PACKAGE_NAME=appify                        (only used if INSTALL_TYPE=deb)

INSTALL_TYPE=""
APPIMAGE_PATH=""
DEB_PACKAGE_NAME="appify"

if [ -f "$CONFIG_FILE" ]; then
    # shellcheck disable=SC1090
    source "$CONFIG_FILE"
fi

bootstrap_config() {
    # Try to figure out how Appify is installed if no config exists yet.
    if dpkg-query -W -f='${Status}' "$DEB_PACKAGE_NAME" 2>/dev/null | grep -q "install ok installed"; then
        INSTALL_TYPE="deb"
        log "Detected deb install of Appify (package: $DEB_PACKAGE_NAME)."
    else
        # Look for a recorded AppImage path in known desktop launcher files.
        local desktop_files=(
            "/usr/share/applications/appify.desktop"
            "/usr/local/share/applications/appify.desktop"
        )
        for df in "${desktop_files[@]}"; do
            if [ -f "$df" ]; then
                local exec_path
                exec_path=$(grep -m1 '^Exec=' "$df" | sed -E 's/^Exec=//; s/ .*//')
                if [ -n "$exec_path" ] && [ -f "$exec_path" ]; then
                    INSTALL_TYPE="appimage"
                    APPIMAGE_PATH="$exec_path"
                    log "Detected AppImage install of Appify at: $APPIMAGE_PATH"
                    break
                fi
            fi
        done
    fi

    if [ -z "$INSTALL_TYPE" ]; then
        log "⚠️ Could not detect how Appify is installed. Skipping this run."
        log "   Create $CONFIG_FILE manually with INSTALL_TYPE=appimage (+ APPIMAGE_PATH=...) or INSTALL_TYPE=deb."
        exit 0
    fi

    {
        echo "INSTALL_TYPE=$INSTALL_TYPE"
        echo "APPIMAGE_PATH=$APPIMAGE_PATH"
        echo "DEB_PACKAGE_NAME=$DEB_PACKAGE_NAME"
    } > "$CONFIG_FILE"
    chmod 644 "$CONFIG_FILE"
}

if [ -z "$INSTALL_TYPE" ]; then
    bootstrap_config
fi

if [ "$INSTALL_TYPE" = "appimage" ] && { [ -z "$APPIMAGE_PATH" ] || [ ! -f "$APPIMAGE_PATH" ]; }; then
    log "❌ INSTALL_TYPE=appimage but APPIMAGE_PATH ('$APPIMAGE_PATH') doesn't exist. Fix $CONFIG_FILE."
    exit 1
fi

# =====================================
# Determine currently installed version
# =====================================
if [ "$INSTALL_TYPE" = "deb" ]; then
    CURRENT_VERSION=$(dpkg-query -W -f='${Version}' "$DEB_PACKAGE_NAME" 2>/dev/null || true)
else
    CURRENT_VERSION=$("$APPIMAGE_PATH" --print-version 2>/dev/null || true)
fi

if [ -z "$CURRENT_VERSION" ]; then
    log "⚠️ Could not determine the currently installed Appify version. Continuing anyway."
    CURRENT_VERSION="0"
else
    log "Current installed Appify version: $CURRENT_VERSION"
fi

# =====================================
# Fetch latest release info from GitHub
# =====================================
log "Checking for the latest Appify release..."
RELEASE_JSON=$(curl -fsSL -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${GITHUB_REPO}/releases/latest") || {
    log "❌ Failed to reach the GitHub releases API."
    exit 1
}

LATEST_TAG=$(echo "$RELEASE_JSON" | grep -m1 '"tag_name"' | sed -E 's/.*"tag_name":[[:space:]]*"([^"]+)".*/\1/')
if [ -z "$LATEST_TAG" ]; then
    log "❌ Failed to parse the latest release tag."
    exit 1
fi
LATEST_VERSION="${LATEST_TAG#v}"

echo "$(date -Iseconds) latest=$LATEST_VERSION" > "$CACHE_FILE" 2>/dev/null || true

log "Latest Appify version available: $LATEST_VERSION"

if dpkg --compare-versions "$CURRENT_VERSION" ge "$LATEST_VERSION" 2>/dev/null; then
    log "✨ Appify is already up to date."
    exit 0
fi

# =====================================
# Download + install the update
# =====================================
if [ "$INSTALL_TYPE" = "appimage" ]; then
    ASSET_URL=$(echo "$RELEASE_JSON" \
        | grep -o '"browser_download_url":[[:space:]]*"[^"]*\.AppImage"' \
        | sed -E 's/.*"(https[^"]+)"/\1/' | head -n1)
    if [ -z "$ASSET_URL" ]; then
        log "❌ No .AppImage asset found in the latest release."
        exit 1
    fi

    TMP_FILE=$(mktemp /tmp/appify.XXXXXX.AppImage)
    log "⬇️  Downloading Appify v$LATEST_VERSION (AppImage)..."
    if ! curl -fsSL -o "$TMP_FILE" "$ASSET_URL"; then
        log "❌ Failed to download the new AppImage."
        rm -f "$TMP_FILE"
        exit 1
    fi
    log "SHA-256: $(sha256sum "$TMP_FILE" | cut -d' ' -f1)"

    chmod +x "$TMP_FILE"
    # Overwrite in place, at the exact path the user originally chose, so
    # desktop launchers/symlinks that point at APPIMAGE_PATH keep working.
    # mv within the same directory is atomic and effectively removes the old file.
    if ! mv -f "$TMP_FILE" "$APPIMAGE_PATH"; then
        log "❌ Failed to install the new AppImage to $APPIMAGE_PATH."
        rm -f "$TMP_FILE"
        exit 1
    fi
    chmod +x "$APPIMAGE_PATH"

    log "✅ Appify has been updated to version $LATEST_VERSION successfully! ($APPIMAGE_PATH)"
    notify_user "Appify has been updated to version $LATEST_VERSION ✅"

else
    DEB_URL=$(echo "$RELEASE_JSON" \
        | grep -o '"browser_download_url":[[:space:]]*"[^"]*\.deb"' \
        | sed -E 's/.*"(https[^"]+)"/\1/' | head -n1)
    if [ -z "$DEB_URL" ]; then
        log "❌ No .deb asset found in the latest release."
        exit 1
    fi

    DEB_FILE=$(mktemp /tmp/appify.XXXXXX.deb)
    log "⬇️  Downloading Appify v$LATEST_VERSION (.deb)..."
    if ! curl -fsSL -o "$DEB_FILE" "$DEB_URL"; then
        log "❌ Failed to download the new .deb package."
        rm -f "$DEB_FILE"
        exit 1
    fi
    log "SHA-256: $(sha256sum "$DEB_FILE" | cut -d' ' -f1)"

    log "📦 Installing Appify v$LATEST_VERSION..."
    if ! apt-get install -y "$DEB_FILE"; then
        log "❌ Installation failed."
        rm -f "$DEB_FILE"
        exit 1
    fi
    rm -f "$DEB_FILE"

    log "✅ Appify has been updated to version $LATEST_VERSION successfully!"
    notify_user "Appify has been updated to version $LATEST_VERSION ✅"
fi
