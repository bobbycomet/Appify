#!/usr/bin/env python3
"""
Appify 2.2.1 - Bug Fix Release

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BUG FIXES/CLEANUP in 2.2.1
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Fixes & Improvements

Fixed an extension conflict between 7TV and FrankerFaceZ caused by recent 7TV changes 
  The update made chat unreadable.
  Other Twitch-related presets are unaffected
  FrankerFaceZ has been removed from presets to prevent breakage

  Replaced Aniwatch preset (service appears unavailable) with Anikai  
  Ensures preset list remains functional and up to date

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BUG FIXES in 2.2.0
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FIX: Unsupported flag warning in Chromium-based PWAs on X11
  --disable-gpu-sandbox was being passed to all Chromium browsers on X11 as
  part of the Nvidia tearing fix. Chromium now flags this as an unsupported
  command-line flag and displays a stability/security warning banner on every
  launch. The flag has been removed — --use-gl=desktop and
  --ignore-gpu-blocklist are sufficient to resolve screen tearing on Nvidia
  hardware and neither triggers the warning.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
BUG FIXES in 2.1.4
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FIX: Screen tearing on X11 with Nvidia (the main issue)
  The root cause was that get_display_backend_flags() returned an empty string
  for X11, leaving Chromium-based browsers without the flags needed for Nvidia's
  direct rendering path. Two fixes were applied:
  - Chromium on X11: Now passes --use-gl=desktop --ignore-gpu-blocklist
    --disable-gpu-sandbox. This forces the native OpenGL backend (bypassing EGL
    paths that cause tearing on Nvidia), ensures hardware acceleration isn't
    wrongly blocked, and lifts the sandbox restriction that prevents Nvidia's
    driver from using its own vsync. A regular browser isn't affected because it
    runs in your desktop session context with full driver access — the PWA wrapper
    was stripping that.
  - Firefox on X11: Added layers.acceleration.force-enabled, layers.omtp.enabled,
    gfx.webrender.all, and gfx.webrender.enabled to the generated user.js. Fresh
    Firefox profiles default to software compositing on some Nvidia + distro
    combos, which is why video in a regular browser profile (which has accumulated
    these prefs over time) looks fine but the blank PWA profile tears.

FIX: Blank line in generated launcher scripts
  When firefox_wayland_env was empty (e.g. Firefox on X11, or any Chromium
  browser), firefox_wayland_env.rstrip('\n') resolved to "", which was inserted
  as a literal empty string in the lines list — producing a stray blank line and
  potentially confusing set -euo pipefail. Now conditionally included with
  *([...] if ... else []).

FIX: launch_app_from_cli ignored per-app nice/ionice
  The CLI launch path was reading nice/ionice from the global config only. It
  now reads from profile_cfg first (the values stored at install time), falling
  back to global defaults. Apps installed with custom CPU/I/O priorities now
  launch with those priorities from the desktop shortcut.

FIX: _SNAP_NAMES dict recreated on every wrapper generation
  The dict was defined inside make_launcher_wrapper, so it was allocated and
  garbage-collected on every install/reinstall. Moved to module level as a
  proper constant.

NEW: Firefox userChrome.css import
  A "Firefox Advanced Options" frame appears in the UI only when Firefox is the
  selected browser. It contains:
  - A Browse… button to select a .css file via file chooser
  - A Clear button to remove the selection
  - A path label showing the currently selected file
  When Install is clicked with a file selected:
  - The source path is saved to profile.json as "userchrome_css_source" so it
    persists across reinstalls and is restored when you re-select the app
  - init_firefox_profile copies the file to <profile>/chrome/userChrome.css
  - toolkit.legacyUserProfileCustomizations.stylesheets is always written to
    user.js (Firefox ignores userChrome.css completely without this pref)

FIX: firefox_wayland_env NameError for Flatpak/Snap Firefox
  The variable was initialised inside the native-only branch but used
  unconditionally afterwards via +=. Flatpak and Snap Firefox wrappers would
  crash with a NameError. Initialisation moved before all branch points.

FIX: DEFAULT_APPS youtube/youtube Music name casing
  Entries were lowercase ("youtube", "youtube Music") but PRESET_DOMAIN_MAP and
  DEFAULT_EXT_PRESETS use title case ("YouTube", "YouTube Music"), causing
  extension preset lookups to silently fail. Now consistently cased.

FIX: Fresh install DEFAULT_CONFIG apps stored as list
  DEFAULT_CONFIG["apps"] was DEFAULT_APPS (a list). A brand-new config has
  config_version=2, so the list→dict migration was skipped, and any code doing
  CONFIG["apps"][slug] = ... would raise TypeError. DEFAULT_CONFIG["apps"] is
  now initialised as a dict via {slugify(a["name"]): a for a in DEFAULT_APPS}.

FIX: tarfile.extractall without members= filter (CVE-2007-4559 hardening)
  The safe_members list built by _safe_member validation was not passed to
  extractall, so new members could theoretically appear between getmembers()
  and extractall(). Now passes members=safe_members explicitly on all Python
  versions, plus filter="data" on 3.12+ for an additional stdlib-level guard.

FIX: Adw.init() called at module level
  Calling Adw.init() at import time crashes any non-GUI use (e.g. --launch-app
  from a desktop shortcut on a headless session, or unit tests). Moved inside
  main() so it only runs when the GTK window is actually being created.

FIX: ext_frame NameError — main window crashed on open
  ext_frame was used (ext_frame.set_label_widget(...)) before being assigned.
  The missing ext_frame = Gtk.Frame() line has been added.

FIX: Custom extension saved without URL validation or allowlist check
  on_add_custom_ext was saving any URL (including javascript: URIs and
  malformed strings) to the profile before checking validity, and never applied
  the _ALLOWED_EXT_HOSTS allowlist used elsewhere. Now validates against the
  same allowlist before saving; shows an error dialog on rejection.

FIX: Clone silently overwrites app with conflicting slug
  on_clone wrote to CONFIG["apps"][new_slug] without checking whether that slug
  already existed. A name collision (e.g. cloning "YouTube" as "youtube") would
  silently overwrite the existing entry. Now shows an error dialog instead.

FIX: _perform_install mutated live CONFIG["apps"] dict in-place
  app["kiosk"], app["gamepad"], and app["browser"] were set directly on the
  dict reference inside CONFIG["apps"], leaving the config in a half-mutated
  state if an exception occurred before save_config(). Now works on a copy and
  writes it back atomically.

FIX: PRESET_DOMAIN_MAP substring matching produced wrong preset matches
  "youtube.com" matched "music.youtube.com" and "studio.youtube.com" before
  their own entries because dict iteration is insertion-order and substring
  matching was used. get_app_key() now sorts PRESET_DOMAIN_MAP by key length
  descending so more-specific entries always win. Also fixed: DEFAULT_EXT_PRESETS
  keys "twitch" and "kick" renamed to "Twitch" and "Kick" to match the title-
  cased values in PRESET_DOMAIN_MAP.

FIX: Extensions marked as installed even when browser launch failed
  on_install_presets called save_installed_extensions unconditionally after
  launch_extension_manager, even if the browser never opened. launch_extension_manager
  now returns True/False, and extensions are only recorded when True.

FIX: Update checker surfaced GitHub draft releases
  check_for_updates only skipped prerelease=True but not draft=True. A draft
  release would be returned as "latest" by the GitHub API and shown to users.
  Now skips both.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FEATURES CARRIED FORWARD FROM 2.1.5
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- INTELLIGENT BROWSER DETECTION: Auto-detects native vs Flatpak installations
- WAYLAND/X11 NATIVE SUPPORT: Automatically configures for your display server
- DEFAULT BROWSER DETECTION: Uses your system's default browser
- 8 Browsers fully supported: Firefox, Edge, Brave, Vivaldi, Chrome, Chromium,
  Opera, Ungoogled Chromium
- Enhanced WebHID with full UI control for cloud gaming
- Auto icon download with corrected icon-cache path
- Extension presets with verified working URLs; --new-window for Chromium installs
- Kiosk, GPU, nice/ionice optimisation (per-app overrides in profile.json)
- Dark mode, full logging, Linux-first design with smart detection
- check_webhid_portal() — detects xdg-desktop-portal daemon + DE-specific backend
  (kde/gnome/cosmic/hyprland/wlr/gtk) before enabling WebHID
- WebHID Gamepad checkbox shows non-blocking advisory dialog if portal not ready
- System info banner shows live WebHID portal status with tooltip
- config_version field (v2) — explicit migration from list→dict app storage
- Cloud gaming default apps auto-enable WebHID gamepad
- Install Custom dialog pre-fills browser from main combo
- Post-install/uninstall dropdown selection reliably re-synced
- Icon= uses absolute path so KDE Wayland resolves icons without cache
- Audio routing via PULSE_PROP removed — browser handles sound natively
- Firefox no longer receives --class/--name/--disable-gpu (unsupported flags)
- user.js JS string injection — backslash/quote escaping in app name & URL
- gtk-update-icon-cache called on correct hicolor theme directory
- save_config() runs after all runtime detections complete
- tar _safe_member: device files unconditionally rejected
"""

import gi
gi.require_version("Gtk", "4.0")
gi.require_version("Gdk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Gio, GLib, Gdk, Adw
import os
import re
import sys
import io
import json
import shutil
import argparse
import subprocess
import tempfile
import shlex
import tarfile
import threading
import datetime
import logging
import stat
from urllib.parse import urlparse
from pathlib import Path
from packaging.version import Version
import gettext

CURRENT_VERSION = "2.2.1"
CONFIG_VERSION  = 2   # Increment when the on-disk schema changes.

# ---------------- Logging (must be first — used throughout the module) --------

def _setup_logger() -> logging.Logger:
    """
    Configures a module-level logger that writes to stderr.
    A FileHandler is attached lazily once LOG_FILE's parent directory exists.
    """
    logger = logging.getLogger("appify")
    if logger.handlers:
        return logger  # Already configured (e.g. during tests).
    logger.setLevel(logging.DEBUG)
    fmt = logging.Formatter(
        "%(asctime)s [%(levelname)s] %(message)s",
        datefmt="%Y-%m-%dT%H:%M:%S",
    )
    sh = logging.StreamHandler(sys.stderr)
    sh.setFormatter(fmt)
    logger.addHandler(sh)
    return logger


_logger = _setup_logger()


def _ensure_file_log_handler():
    """Attaches a FileHandler to the module logger once LOG_FILE is available."""
    for h in _logger.handlers:
        if isinstance(h, logging.FileHandler):
            return
    try:
        LOG_FILE.parent.mkdir(parents=True, exist_ok=True)
        fh = logging.FileHandler(str(LOG_FILE), encoding="utf-8")
        fh.setFormatter(logging.Formatter(
            "%(asctime)s [%(levelname)s] %(message)s",
            datefmt="%Y-%m-%dT%H:%M:%S",
        ))
        _logger.addHandler(fh)
    except Exception as exc:
        _logger.warning("Could not attach file log handler: %s", exc)


def log_debug(msg: str):
    """Convenience wrapper — logs at DEBUG level."""
    _ensure_file_log_handler()
    _logger.debug(msg)




# ---------------- Internationalization (i18n) ----------------

def setup_i18n():
    """
    Detects the system language and loads a matching appify.mo translation file.
    Searches all standard locale directories used across Linux distros:
      - Debian/Ubuntu:        /usr/share/locale/
      - Arch Linux:           /usr/share/locale/
      - Fedora/RHEL:          /usr/share/locale/
      - AppImage (bundled):   $APPDIR/usr/share/locale/
      - User-local override:  ~/.local/share/locale/
      - Next to this script:  ./locale/  (dev/testing)

    If no .mo file is found for the detected language, silently falls back
    to English (identity function) — no errors, no crashes.

    To add a translation:
      1. Extract strings:  xgettext -L Python -o appify.pot Appify.py
      2. Create .po:       msginit -l de_DE -o locale/de_DE/LC_MESSAGES/appify.po
      3. Compile .mo:      msgfmt locale/de_DE/LC_MESSAGES/appify.po -o locale/de_DE/LC_MESSAGES/appify.mo
      4. Install .mo to:   /usr/share/locale/de_DE/LC_MESSAGES/appify.mo
    """
    lang = (
        os.environ.get("LC_ALL")
        or os.environ.get("LANGUAGE")
        or os.environ.get("LANG")
        or ""
    ).split(".")[0].split(":")[0]

    if not lang or lang.lower().startswith("c") or lang.lower() == "posix":
        return lambda s: s

    search_dirs = []
    search_dirs.append(Path.home() / ".local" / "share" / "locale")

    appdir = os.environ.get("APPDIR")
    if appdir:
        search_dirs.append(Path(appdir) / "usr" / "share" / "locale")

    for p in [
        "/usr/share/locale",
        "/usr/local/share/locale",
        "/var/lib/flatpak/exports/share/locale",
        "/snap/core/current/usr/share/locale",
    ]:
        search_dirs.append(Path(p))

    search_dirs.append(Path(__file__).parent / "locale")

    lang_variants = [lang]
    if "_" in lang:
        lang_variants.append(lang.split("_")[0])

    for locale_dir in search_dirs:
        for lang_code in lang_variants:
            mo_path = locale_dir / lang_code / "LC_MESSAGES" / "appify.mo"
            if mo_path.exists():
                try:
                    translation = gettext.translation(
                        domain="appify",
                        localedir=str(locale_dir),
                        languages=[lang_code],
                        fallback=False,
                    )
                    _logger.info("Loaded translation: %s", mo_path)
                    return translation.gettext
                except Exception as e:
                    _logger.warning("Translation load failed (%s): %s", mo_path, e)
                    continue

    return lambda s: s

_ = setup_i18n()

# ---------------- Browser Detection System ----------------

# Maps desktop-file stems (and Flatpak app-IDs) to our internal browser keys.
# A single authoritative constant used by all detection paths in
# get_default_browser() so that adding a new browser only requires one edit.
BROWSER_DESKTOP_MAP: dict[str, str] = {
    # Firefox
    "firefox":              "firefox",
    "org.mozilla.firefox":  "firefox",

    # Edge
    "microsoft-edge":       "edge",
    "com.microsoft.edge":   "edge",
    "msedge":               "edge",
    "edge":                 "edge",

    # Brave
    "brave":                "brave",
    "brave-browser":        "brave",
    "com.brave.browser":    "brave",

    # Vivaldi
    "vivaldi":              "vivaldi",
    "com.vivaldi.vivaldi":  "vivaldi",

    # Chrome
    "google-chrome":        "chrome",
    "com.google.chrome":    "chrome",
    "chrome":               "chrome",

    # Chromium
    "chromium":             "chromium",
    "chromium-browser":     "chromium",
    "org.chromium.chromium":"chromium",

    # Opera
    "opera":                "opera",
    "com.opera.opera":      "opera",
}

# Maps our internal browser keys to snap package names (they differ for some
# browsers).  Defined at module level so it is not recreated on every call to
# make_launcher_wrapper().
_SNAP_NAMES: dict[str, str] = {
    "firefox":            "firefox",
    "edge":               "microsoft-edge",
    "brave":              "brave",
    "vivaldi":            "vivaldi",
    "chrome":             "google-chrome",
    "chromium":           "chromium",
    "opera":              "opera",
    "ungoogled-chromium": "ungoogled-chromium",
}

def is_wayland_session() -> bool:
    """Detects if the current session is Wayland"""
    return bool(os.environ.get('WAYLAND_DISPLAY'))

def is_x11_session() -> bool:
    """Detects if the current session is X11"""
    return bool(os.environ.get('DISPLAY')) and not is_wayland_session()

def get_session_type() -> str:
    """Returns 'wayland', 'x11', or 'unknown'"""
    if is_wayland_session():
        return "wayland"
    elif is_x11_session():
        return "x11"
    return "unknown"

def detect_wayland_compositor() -> str:
    """
    Detects the active Wayland compositor/desktop environment.
    Returns one of: 'gnome', 'kde', 'sway', 'hyprland', 'wlroots',
                    'cosmic', 'wayfire', 'river', 'labwc', 'unknown'

    Detection strategy (cheapest first):
      1. Check well-known environment variables set by specific compositors.
      2. Check XDG_CURRENT_DESKTOP / DESKTOP_SESSION.
      3. Check SWAYSOCK / HYPRLAND_INSTANCE_SIGNATURE sockets.
      4. Fall back to 'unknown'.
    """
    if not is_wayland_session():
        return "unknown"

    # --- Direct compositor env vars ---
    if os.environ.get("HYPRLAND_INSTANCE_SIGNATURE"):
        return "hyprland"
    if os.environ.get("SWAYSOCK"):
        return "sway"

    # --- Desktop environment vars ---
    xdg = (os.environ.get("XDG_CURRENT_DESKTOP") or "").lower()
    ds  = (os.environ.get("DESKTOP_SESSION") or "").lower()
    combined = f"{xdg} {ds}"

    if "gnome" in combined:
        return "gnome"
    if "kde" in combined or "plasma" in combined:
        return "kde"
    if "sway" in combined:
        return "sway"
    if "hyprland" in combined:
        return "hyprland"
    if "cosmic" in combined:
        return "cosmic"
    if "wayfire" in combined:
        return "wayfire"
    if "river" in combined:
        return "river"
    if "labwc" in combined:
        return "labwc"

    # --- Try querying the compositor via wlr-randr / wayland socket heuristics ---
    # Check running processes for well-known compositor binaries
    try:
        procs = subprocess.run(
            ["ps", "-eo", "comm"], capture_output=True, text=True, timeout=2
        ).stdout.lower()
        if "gnome-shell" in procs:
            return "gnome"
        if "kwin_wayland" in procs:
            return "kde"
        if "sway" in procs:
            return "sway"
        if "hyprland" in procs:
            return "hyprland"
        if "cosmic-comp" in procs:
            return "cosmic"
        if "wayfire" in procs:
            return "wayfire"
        if "river" in procs:
            return "river"
        if "labwc" in procs:
            return "labwc"
    except Exception:
        pass

    return "unknown"

def get_display_backend_flags(browser_key: str = "") -> str:
    """
    Returns appropriate display-backend flags for the current session and browser.

    Rules:
      • X11  → Nvidia tearing fix: --use-gl=desktop --ignore-gpu-blocklist
          - --use-gl=desktop forces the native OpenGL backend, bypassing EGL
            paths that cause tearing on Nvidia.
          - --ignore-gpu-blocklist prevents Chromium from wrongly disabling
            hardware acceleration on some Nvidia driver versions.
          - Note: --disable-gpu-sandbox is intentionally NOT included; it
            triggers an "unsupported flag" security warning in Chromium and
            is not required for the tearing fix.
      • Wayland + Chromium-based:
          - Most compositors: --ozone-platform=wayland + window decoration hint
          - KDE/KWin: also add UseWaylandDecorations (server-side decorations)
          - GNOME Mutter: standard ozone flags work fine
          - wlroots-based (sway, hyprland, river, labwc, wayfire):
            add WaylandWindowDecorations + --enable-wayland-ime
      • Unknown session → --ozone-platform-hint=auto (let Chromium decide)

    Firefox is intentionally NOT touched here; its kiosk mode must not receive
    --ozone or GDK_BACKEND flags as arguments (that breaks kiosk on Wayland).
    Firefox Wayland support is handled via the environment in make_launcher_wrapper.
    """
    session = get_session_type()
    chromium_browsers = [
        "edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"
    ]

    if browser_key.lower() not in chromium_browsers:
        # Firefox / unknown — handled elsewhere; return empty.
        return ""

    if session == "x11":
        # On X11 with Nvidia, Chromium's default GPU path can produce screen
        # tearing because it falls back to software compositing or uses EGL
        # paths that bypass the driver's vsync.  Forcing the native OpenGL
        # backend (--use-gl=desktop) eliminates tearing on all tested Nvidia
        # driver generations (470 – 550).
        # --ignore-gpu-blocklist is needed on some driver versions where
        # Chromium mistakenly blocks hardware acceleration for Nvidia cards.
        # These flags are harmless on non-Nvidia hardware.
        # --disable-gpu-sandbox is deliberately omitted: it causes Chromium to
        # display an "unsupported command-line flag" security warning and is not
        # necessary for the tearing fix.
        return (
            "--use-gl=desktop "
            "--ignore-gpu-blocklist"
        )

    if session == "wayland":
        compositor = detect_wayland_compositor()
        base = "--ozone-platform=wayland --enable-features=UseOzonePlatform"

        if compositor == "kde":
            # KDE Plasma supports server-side window decorations via xdg-decoration.
            return f"{base},WaylandWindowDecorations"

        if compositor in ("sway", "hyprland", "river", "labwc", "wayfire"):
            # wlroots compositors: add WaylandWindowDecorations + sandbox hint.
            return (
                f"{base},WaylandWindowDecorations "
                "--enable-wayland-ime"
            )

        if compositor in ("gnome", "cosmic"):
            # GNOME Mutter / COSMIC: standard flags; CSD handled by the toolkit.
            return f"{base},WaylandWindowDecorations"

        # Generic / unknown Wayland compositor: safe defaults.
        return f"{base},WaylandWindowDecorations"

    # Unknown session type: let Chromium auto-detect.
    return "--ozone-platform-hint=auto"

def detect_browser_installation(browser_key: str) -> dict:
    """
    Detects how a browser is installed and returns installation info.
    Returns: {
        'type': 'native' | 'flatpak' | 'snap' | 'not_found',
        'cmd': actual command to use,
        'display_name': human-readable name
    }
    """
    browsers_info = {
        "firefox": {
            "native_cmds": ["firefox", "/usr/bin/firefox"],
            "flatpak": "org.mozilla.firefox",
            "snap": "firefox",
            "name": "Firefox"
        },
        "edge": {
            "native_cmds": ["microsoft-edge", "microsoft-edge-stable"],
            "flatpak": "com.microsoft.Edge",
            "snap": "microsoft-edge",
            "name": "Microsoft Edge"
        },
        "brave": {
            "native_cmds": ["brave-browser-stable", "brave-browser", "brave"],
            "flatpak": "com.brave.Browser",
            "snap": "brave",
            "name": "Brave"
        },
        "vivaldi": {
            "native_cmds": ["vivaldi", "vivaldi-stable"],
            "flatpak": "com.vivaldi.Vivaldi",
            "snap": "vivaldi",
            "name": "Vivaldi"
        },
        "chrome": {
            "native_cmds": ["google-chrome", "google-chrome-stable"],
            "flatpak": "com.google.Chrome",
            "snap": "google-chrome",
            "name": "Google Chrome"
        },
        "chromium": {
            "native_cmds": ["chromium", "chromium-browser"],
            "flatpak": "org.chromium.Chromium",
            "snap": "chromium",
            "name": "Chromium"
        },
        "opera": {
            "native_cmds": ["opera", "opera-stable"],
            "flatpak": "com.opera.Opera",
            "snap": "opera",
            "name": "Opera"
        },
        "ungoogled-chromium": {
            "native_cmds": ["ungoogled-chromium"],
            "flatpak": None,
            "snap": None,
            "name": "Ungoogled Chromium"
        }
    }
    
    if browser_key not in browsers_info:
        return {'type': 'not_found', 'cmd': '', 'display_name': browser_key}
    
    info = browsers_info[browser_key]
    
    # Check native installation first
    for cmd in info["native_cmds"]:
        if shutil.which(cmd):
            return {
                'type': 'native',
                'cmd': cmd,
                'display_name': f"{info['name']} (Native)"
            }
    
    # Check Flatpak
    if info.get("flatpak"):
        try:
            result = subprocess.run(
                ["flatpak", "info", info["flatpak"]], 
                capture_output=True, 
                text=True,
                timeout=2
            )
            if result.returncode == 0:
                return {
                    'type': 'flatpak',
                    'cmd': f"flatpak run {info['flatpak']}",
                    'flatpak_id': info['flatpak'],
                    'display_name': f"{info['name']} (Flatpak)"
                }
        except Exception:
            pass
    
    # Check Snap
    if info.get("snap"):
        try:
            result = subprocess.run(
                ["snap", "list", info["snap"]],
                capture_output=True,
                text=True,
                timeout=2
            )
            if result.returncode == 0:
                return {
                    'type': 'snap',
                    'cmd': f"snap run {info['snap']}",
                    'snap_name': info['snap'],
                    'display_name': f"{info['name']} (Snap)"
                }
        except Exception:
            pass
    
    return {
        'type': 'not_found',
        'cmd': '',
        'display_name': f"{info['name']} (Not Installed)"
    }


def get_default_browser() -> str:
    """
    Detects the system's default browser.
    Returns browser key like 'firefox', 'chrome', etc.
    """
    try:
        # Try xdg-settings first (most reliable)
        result = subprocess.run(
            ["xdg-settings", "get", "default-web-browser"],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode == 0:
            desktop_file = result.stdout.strip().lower()
            
            # Map desktop file names to our browser keys
            # Handles both simple names and reverse domain notation (com.company.App.desktop)
            browser_map = BROWSER_DESKTOP_MAP
            
            # First try exact match (without .desktop extension)
            desktop_name = desktop_file.replace('.desktop', '')
            if desktop_name in browser_map:
                return browser_map[desktop_name]
            
            # Then try substring matching
            for key, browser_key in browser_map.items():
                if key in desktop_file:
                    return browser_key
    except Exception:
        pass
    
    # Try alternative method: check mimeapps.list
    try:
        mimeapps_paths = [
            Path.home() / '.config/mimeapps.list',
            Path.home() / '.local/share/applications/mimeapps.list',
            Path('/etc/xdg/mimeapps.list'),
        ]
        
        for mimeapps_path in mimeapps_paths:
            if mimeapps_path.exists():
                with open(mimeapps_path, 'r') as f:
                    content = f.read().lower()
                    
                    # Look for text/html or x-scheme-handler/http handlers
                    browser_patterns = BROWSER_DESKTOP_MAP
                    
                    # Check for text/html association
                    for pattern, browser_key in browser_patterns.items():
                        if f'text/html={pattern}' in content or f'x-scheme-handler/http={pattern}' in content:
                            return browser_key
    except Exception:
        pass
    
    # Try gio (GNOME/GTK default handler)
    try:
        result = subprocess.run(
            ["gio", "mime", "x-scheme-handler/http"],
            capture_output=True,
            text=True,
            timeout=2
        )
        if result.returncode == 0:
            desktop_file = result.stdout.strip().lower()
            
            browser_map = BROWSER_DESKTOP_MAP
            
            for key, browser_key in browser_map.items():
                if key in desktop_file:
                    return browser_key
    except Exception:
        pass
    
    # Fallback: Return the first INSTALLED browser from this priority list
    # This ensures we don't default to Firefox if it's not even installed
    priority_order = ['edge', 'firefox', 'chrome', 'brave', 'chromium', 'vivaldi', 'opera']
    for browser in priority_order:
        detection = detect_browser_installation(browser)
        if detection['type'] != 'not_found':
            return browser
    
    # Ultimate fallback - only if no browsers found at all
    return 'firefox'

def scan_available_browsers() -> dict:
    """
    Scans system for all available browsers.
    Returns dict mapping browser_key to detection info.
    """
    browsers = {}
    for browser_key in ["firefox", "edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"]:
        detection = detect_browser_installation(browser_key)
        if detection['type'] != 'not_found':
            browsers[browser_key] = detection
    return browsers

# ---------------- XDG Desktop Portal Detection ----------------

# Maps compositor/DE names (as returned by detect_wayland_compositor()) to the
# package/binary name of the portal backend that provides device-permission
# dialogs (including WebHID/gamepad).  Used only for advisory warnings — the
# browser itself still works without the portal, but the user may be silently
# denied HID access.
_PORTAL_BACKENDS: dict[str, str] = {
    "kde":       "xdg-desktop-portal-kde",
    "gnome":     "xdg-desktop-portal-gnome",
    "cosmic":    "xdg-desktop-portal-cosmic",
    "hyprland":  "xdg-desktop-portal-hyprland",
    "sway":      "xdg-desktop-portal-wlr",
    "river":     "xdg-desktop-portal-wlr",
    "labwc":     "xdg-desktop-portal-wlr",
    "wayfire":   "xdg-desktop-portal-wlr",
    # X11 / generic Wayland sessions use the GTK portal as a safe default.
    "x11":       "xdg-desktop-portal-gtk",
    "unknown":   "xdg-desktop-portal-gtk",
}


def check_webhid_portal() -> dict:
    """
    Checks whether the xdg-desktop-portal stack required for WebHID/gamepad
    device-permission dialogs is present and running.

    Returns a dict with keys:
      'ok'       (bool)  – True if everything needed appears to be in place.
      'portal'   (str)   – Name of the portal backend we looked for.
      'reason'   (str)   – Human-readable explanation when ok=False.
      'running'  (bool)  – Whether xdg-desktop-portal daemon is running.
      'backend_found' (bool) – Whether the DE-specific backend binary exists.

    Detection strategy (cheapest checks first):
      1. Verify the base xdg-desktop-portal binary is on PATH.
      2. Check whether the portal daemon is running (via pgrep or D-Bus).
      3. Determine which DE-specific backend is expected for the current session.
      4. Check whether that backend binary exists on PATH or in /usr/libexec/.
    """
    compositor = detect_wayland_compositor() if is_wayland_session() else "x11"
    portal_pkg = _PORTAL_BACKENDS.get(compositor, "xdg-desktop-portal-gtk")

    result: dict = {
        "ok": False,
        "portal": portal_pkg,
        "reason": "",
        "running": False,
        "backend_found": False,
    }

    # ── Step 1: base portal binary ────────────────────────────────────────────
    if not shutil.which("xdg-desktop-portal"):
        result["reason"] = (
            "xdg-desktop-portal is not installed. "
            "WebHID/gamepad permission dialogs will not appear and device access "
            "may be silently denied by the browser sandbox."
        )
        return result

    # ── Step 2: is the portal daemon running? ─────────────────────────────────
    try:
        pgrep = subprocess.run(
            ["pgrep", "-x", "xdg-desktop-por"],  # process name is truncated by kernel
            capture_output=True, timeout=2,
        )
        if pgrep.returncode != 0:
            # Try the full name in case the kernel didn't truncate it.
            pgrep = subprocess.run(
                ["pgrep", "-f", "xdg-desktop-portal"],
                capture_output=True, timeout=2,
            )
        result["running"] = pgrep.returncode == 0
    except Exception:
        result["running"] = False

    # ── Step 3: check for the DE-specific backend binary ─────────────────────
    # Backends typically live in /usr/libexec/ or /usr/lib/ rather than on PATH.
    extra_dirs = [
        "/usr/libexec",
        "/usr/lib/xdg-desktop-portal",
        "/usr/lib",
        "/usr/local/libexec",
    ]
    backend_found = bool(shutil.which(portal_pkg))
    if not backend_found:
        # Also search libexec directories.
        backend_found = any(
            (Path(d) / portal_pkg).exists() for d in extra_dirs
        )
    result["backend_found"] = backend_found

    # ── Step 4: synthesise result ─────────────────────────────────────────────
    if not result["running"]:
        result["reason"] = (
            f"xdg-desktop-portal is installed but not running. "
            f"Start it with: systemctl --user start xdg-desktop-portal"
        )
        return result

    if not backend_found:
        result["reason"] = (
            f"The portal daemon is running but the {compositor.upper()} backend "
            f"({portal_pkg}) was not found. "
            f"Install it with your package manager to enable WebHID/gamepad "
            f"permission dialogs."
        )
        return result

    result["ok"] = True
    result["reason"] = f"Portal OK ({portal_pkg} present and daemon running)"
    return result

# ---------------- Utilities ----------------

def slugify(text: str) -> str:
    """Converts a string to a URL-friendly slug."""
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")

def sanitize_shell_string(value: str) -> str:
    """
    Strips characters that could be interpreted as shell metacharacters when a
    value is interpolated inside a double-quoted bash string.

    We allow the full URL character-set (RFC 3986 unreserved + common
    sub-delimiters) plus a small whitelist of extras that appear legitimately
    in app names and paths.  Anything outside that set is silently removed.

    This is a defence-in-depth measure.  Values are also always placed inside
    double-quoted strings in the generated bash scripts, but stripping
    metacharacters prevents backtick/dollar/quote injection even if quoting is
    accidentally omitted in a future edit.

    Safe chars kept:
      - Alphanumerics and _ - . ~ (URL unreserved)
      - : / ? = & # % + @ (URL sub-delimiters / path / query)
      - Space (common in app names)
    """
    return re.sub(r'[^a-zA-Z0-9 _.~/:?=&#%+@-]', '', value)

def get_browsers():
    """Returns the browser configuration dictionary."""
    return CONFIG.get("browsers", DEFAULT_CONFIG.get("browsers", {}))

def get_profile_dir(app: dict) -> Path:
    """Calculates the PWA's isolated profile directory path."""
    app_name = app.get("name", "untitled")
    return CONFIG_DIR / "profiles" / slugify(app_name)

def profile_config_path(app: dict) -> Path:
    """Calculates the path to the profile's config file."""
    return get_profile_dir(app) / "profile.json"

def load_profile_config(app: dict) -> dict:
    """Loads the config for a specific PWA profile."""
    p = profile_config_path(app)
    if p.exists():
        try:
            return json.loads(p.read_text())
        except Exception:
            return {}
    return {}

def save_profile_config(app: dict, data: dict):
    """Saves the config for a specific PWA profile atomically with owner-only permissions."""
    pd = get_profile_dir(app)
    pd.mkdir(parents=True, exist_ok=True)
    target = profile_config_path(app)
    tmp = target.with_suffix(".json.tmp")
    try:
        tmp.write_text(json.dumps(data, indent=2), encoding="utf-8")
        tmp.chmod(0o600)
        tmp.rename(target)
    except Exception as exc:
        _logger.error("save_profile_config failed: %s", exc)
        tmp.unlink(missing_ok=True)
        raise

def get_hostname_from_url(url: str) -> str:
    """Extracts the clean hostname from a URL."""
    try:
        parsed = urlparse(url)
        hostname = parsed.netloc or parsed.path
        return hostname.replace('www.', '').split('/')[0].split(':')[0]
    except Exception:
        return ""

def check_for_updates(callback):
    """
    Checks GitHub for a newer release in a background thread, then calls
    *callback* with a notification message or None.

    Uses only stdlib (urllib) so the `requests` package is not required.
    """
    def _check():
        try:
            import urllib.request
            import ssl

            url = "https://api.github.com/repos/bobbycomet/Appify/releases/latest"
            ctx = ssl.create_default_context()  # Validates server certificate.
            req = urllib.request.Request(
                url,
                headers={"Accept": "application/vnd.github+json", "User-Agent": f"Appify/{CURRENT_VERSION}"},
            )
            with urllib.request.urlopen(req, context=ctx, timeout=8) as resp:
                if resp.status != 200:
                    return
                data = json.loads(resp.read().decode())

            if data.get("prerelease") or data.get("draft"):
                return

            latest_tag = data["tag_name"].lstrip("v")
            latest_version  = Version(latest_tag)
            current_version = Version(CURRENT_VERSION)

            if latest_version > current_version:
                msg = f"New version available: {data['tag_name']}!\nDownload from GitHub Releases."
                GLib.idle_add(callback, msg)

        except Exception as exc:
            _logger.debug("Update check failed: %s", exc)

    threading.Thread(target=_check, daemon=True).start()

# ---------------- Extension Helpers ----------------

def get_app_key(app):
    hostname = get_hostname_from_url(app.get("url", ""))
    # Sort by key length descending so more-specific entries (e.g.
    # "music.youtube.com") are checked before shorter ones ("youtube.com")
    # and we don't accidentally match the wrong preset via substring.
    for domain_substring, preset_key in sorted(
        PRESET_DOMAIN_MAP.items(), key=lambda kv: len(kv[0]), reverse=True
    ):
        if domain_substring in hostname:
            # Normalize to match DEFAULT_EXT_PRESETS keys (case-insensitive).
            normalized = next(
                (k for k in DEFAULT_EXT_PRESETS if k.lower() == preset_key.lower()),
                preset_key,
            )
            return normalized
    return "generic_pwa"

def get_available_presets(app):
    """Returns a list of extensions available for the current app that are not yet installed."""
    preset_key = get_app_key(app)
    if not preset_key:
        return []

    all_presets = DEFAULT_EXT_PRESETS.get(preset_key, [])
    installed_exts = load_installed_extensions(app)
    installed_names = {ext["name"] for ext in installed_exts}

    return [p for p in all_presets if p["name"] not in installed_names]

def load_installed_extensions(app):
    if not app:
        return []
    profile_cfg = load_profile_config(app)
    return profile_cfg.get("extensions", [])

def save_installed_extensions(app, exts):
    profile_cfg = load_profile_config(app)
    profile_cfg["extensions"] = exts
    save_profile_config(app, profile_cfg)

def get_icon_path(app: dict) -> Path:
    """Calculates the path to the PWA's icon file."""
    return ICON_DIR / f"{slugify(app['name'])}.png"

def get_desktop_file_path(app: dict) -> Path:
    """Calculates the path to the PWA's desktop file."""
    return DESKTOP_DIR / f"pwa-{slugify(app['name'])}-manager.desktop"

def download_file(url: str, path: Path, timeout: int = 10) -> bool:
    """
    Downloads a file using curl with security guardrails.

    Guardrails:
      --max-filesize  : Refuses downloads larger than 2 MB (icons only).
      --max-time      : Hard wall-clock timeout for the whole transfer.
      --connect-timeout: Caps TCP connection time independently.
      --proto         : Restricts to https/http only (no file://, ftp://, etc.).
      --no-sessionid  : Prevents TLS session-ID tracking across requests.
      -L              : Follows redirects (needed for CDNs).
      -f              : Fail silently on HTTP errors (4xx/5xx).
      -s              : Silent mode; errors handled by returncode.
    """
    try:
        subprocess.run(
            [
                "curl",
                "-fLs",
                "--proto", "https,http",
                "--max-filesize", "2097152",  # 2 MB
                "--connect-timeout", "5",
                "--max-time", str(timeout),
                "--no-sessionid",
                "-o", str(path),
                url,
            ],
            check=True,
            timeout=timeout + 5,
        )
        return True
    except Exception:
        return False

def validate_url(url: str) -> bool:
    """
    Returns True if *url* is a valid http/https URL with a non-empty hostname.
    Rejects anything that is not strictly http:// or https://, including
    data: URIs, file: paths, javascript: and other schemes that could be
    misused if user-supplied values reach a browser launcher.
    """
    try:
        parsed = urlparse(url)
        return (
            parsed.scheme in ("http", "https")
            and bool(parsed.netloc)
            and len(url) <= 2048  # Sane upper bound
        )
    except Exception:
        return False


def download_icon(app: dict, status_callback=None):
    """
    Attempts to download an icon for the PWA.
    Validates the downloaded file contains PNG/ICO magic bytes before keeping it.
    After a successful download the icon theme cache is refreshed so that
    KDE Wayland (and other desktops) pick up the new icon immediately.
    """
    hostname = get_hostname_from_url(app['url'])
    if not hostname:
        if status_callback:
            status_callback("Failed to parse hostname")
        return
    icon_path = get_icon_path(app)
    ICON_DIR.mkdir(parents=True, exist_ok=True)

    def _is_image(p: Path) -> bool:
        """Quick magic-byte check: PNG, ICO, JPEG, or GIF."""
        if not p.exists() or p.stat().st_size < 8:
            return False
        try:
            header = p.read_bytes()[:8]
            return (
                header[:4] == b'\x89PNG'               # PNG
                or header[:2] in (b'\xff\xd8',)         # JPEG
                or header[:3] == b'GIF'                 # GIF
                or header[:4] == b'\x00\x00\x01\x00'   # ICO
                or header[:2] == b'BM'                  # BMP
                or header[:4] == b'RIFF'                # WebP container
            )
        except Exception:
            return False

    sources = [
        f"https://icon.horse/icon/{hostname}?size=large",
        f"https://www.google.com/s2/favicons?domain={hostname}&sz=256",
    ]

    # Also try the site's own favicon
    try:
        parsed = urlparse(app['url'])
        if parsed.scheme and parsed.netloc:
            sources.append(f"{parsed.scheme}://{parsed.netloc}/favicon.ico")
    except Exception:
        pass

    for src in sources:
        if download_file(src, icon_path, timeout=8):
            if _is_image(icon_path):
                label = "Icon" if src == sources[0] else "Fallback icon"
                if status_callback:
                    status_callback(f"{label}: {hostname}")
                # Refresh the GTK icon theme cache so KDE Wayland and other
                # desktops see the new icon without requiring a logout/login.
                # ICON_DIR is  …/hicolor/512x512/apps/  so parents[1] is the
                # hicolor theme root (…/.local/share/icons/hicolor/).
                try:
                    icon_theme_root = ICON_DIR.parents[1]
                    subprocess.run(
                        ["gtk-update-icon-cache", "-f", "-t", str(icon_theme_root)],
                        check=False,
                        capture_output=True,
                        timeout=5,
                    )
                except Exception as cache_exc:
                    _logger.debug("gtk-update-icon-cache failed (non-fatal): %s", cache_exc)
                return
            else:
                # Downloaded something that isn't an image — remove it.
                icon_path.unlink(missing_ok=True)

    if status_callback:
        status_callback("Icon download failed")

def make_launcher_wrapper(app: dict, browser_key: str, nice: int, ionice: int, gpu: bool) -> Path:
    """
    Create a shell wrapper for launching PWAs with proper nice/ionice priority settings.
    Enhanced with full WebHID support and intelligent Wayland/X11 detection.

    Sound is handled natively by the browser; no audio routing/PULSE_PROP
    manipulation is performed here.

    Security notes:
      - All user-supplied values (URL, profile path, app name) are passed to
        the script via quoted shell variables, not string-interpolated directly
        into command arguments.  This prevents shell metacharacter injection
        even if sanitize_shell_string() misses an edge case in the future.
      - nice/ionice values are validated to their legal integer ranges before
        being written to the script.
    """
    # ── Clamp nice/ionice to legal ranges ──────────────────────────────────
    nice = max(-20, min(19, int(nice)))
    ionice = max(0, min(3, int(ionice)))

    slug = slugify(app['name'])
    scripts_dir = CONFIG_DIR / "scripts"
    scripts_dir.mkdir(parents=True, exist_ok=True)
    wrapper = scripts_dir / f"pwa-launch-{slug}.sh"
    profile_dir = get_profile_dir(app)
    profile_dir.mkdir(parents=True, exist_ok=True)
    # Restrict profile directory to owner-only access.
    try:
        profile_dir.chmod(0o700)
    except Exception:
        pass

    browser_cfg = get_browsers().get(browser_key, {})
    browser_detection = detect_browser_installation(browser_key)

    if browser_detection['type'] == 'not_found':
        _logger.warning("Browser %s not found — wrapper stub written", browser_key)
        wrapper.write_text(
            "#!/usr/bin/env bash\necho 'ERROR: browser not found' >&2\nexit 1\n"
        )
        wrapper.chmod(0o755)
        return wrapper

    kiosk_flag = browser_cfg.get('kiosk_flag', '') if app.get('kiosk', False) else ''
    args_data = browser_cfg.get('args', '{profile_dir} {url}')
    args_template = ' '.join(args_data) if isinstance(args_data, list) else str(args_data)

    # Sanitize the URL (strips metacharacters as a defence-in-depth measure).
    app_url = sanitize_shell_string(app.get('url', ''))

    unique_wm_class = f"PWA-{slug}"
    chromium_based = browser_key.lower() in [
        "edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"
    ]

    if chromium_based:
        wm_class_arg = f"--class={unique_wm_class} --name={unique_wm_class}"
    else:
        wm_class_arg = ""

    args = args_template.format(
        profile_dir=str(profile_dir),
        url=app_url,
        kiosk_flag=kiosk_flag,
    )

    # === ENHANCED GAMEPAD / WebHID SUPPORT + WAYLAND/X11 ===
    extra_args = ""
    if chromium_based:
        display_flags = get_display_backend_flags(browser_key)

        if app.get("gamepad", False):
            # Warn if the xdg-desktop-portal stack is not ready — without it
            # the browser sandbox may silently deny WebHID device access.
            portal_status = check_webhid_portal()
            if not portal_status["ok"]:
                _logger.warning(
                    "WebHID/gamepad enabled for '%s' but portal check failed: %s",
                    app.get("name", "?"),
                    portal_status["reason"],
                )
            cfg_extra = browser_cfg.get("extra_flags", "").strip()
            if not cfg_extra:
                cfg_extra = (
                    "--enable-features=WebHID"
                    " --enable-gamepad-button-axis-events"
                    " --disable-features=WebHidBlocklist"
                )
            extra_flags = f"{cfg_extra} {display_flags}".strip()
        else:
            extra_flags = display_flags

        if extra_flags.strip():
            extra_args = f" {extra_flags.strip()}"

    if not gpu and chromium_based:
        extra_args += " --disable-gpu"

    args += extra_args

    # ── Initialise firefox_wayland_env before branching ─────────────────────
    # Must be set here — before ALL branches — because the unconditional
    # MOZ_APP_REMOTINGNAME block below uses += on this variable regardless of
    # whether the flatpak/snap/native branch was taken.  Without this
    # initialisation, Flatpak and Snap Firefox wrappers raise a NameError.
    firefox_wayland_env = ""

    if browser_detection['type'] == 'flatpak':
        flatpak_id = browser_detection.get('flatpak_id', '')
        if not flatpak_id:
            _logger.error("Flatpak ID missing for %s — cannot build wrapper", browser_key)
            wrapper.write_text(
                "#!/usr/bin/env bash\necho 'ERROR: flatpak_id missing' >&2\nexit 1\n"
            )
            wrapper.chmod(0o755)
            return wrapper
        exec_cmd = f"$NICE_CMD $IONICE_CMD flatpak run {shlex.quote(flatpak_id)} {args}"
        if chromium_based:
            exec_cmd += f" {wm_class_arg}"
    elif browser_detection['type'] == 'snap':
        snap_name = _SNAP_NAMES.get(browser_key, browser_key)
        exec_cmd = f"$NICE_CMD $IONICE_CMD snap run {shlex.quote(snap_name)} {args}"
        if chromium_based:
            exec_cmd += f" {wm_class_arg}"
    else:  # native
        cmd = browser_detection['cmd']

        # Special handling for Firefox kiosk mode
        if browser_key == "firefox" and app.get('kiosk', False):
            session_type = get_session_type()
            compositor  = detect_wayland_compositor()

            env_vars = []
            if session_type == "wayland":
                env_vars.append("MOZ_ENABLE_WAYLAND=1")
                if compositor == "kde":
                    env_vars.append("GTK_USE_PORTAL=1")
            # No special env needed for X11 — Firefox defaults to X11 backend

            env_prefix = ("env " + " ".join(env_vars)) if env_vars else ""
            cmd_quoted = shlex.quote(cmd)
            # Build exec line: only include env prefix when there are vars to set.
            exec_parts = ["exec", "setsid", "$NICE_CMD", "$IONICE_CMD"]
            if env_prefix:
                exec_parts.append(env_prefix)
            exec_parts.append(cmd_quoted)
            exec_line = " ".join(exec_parts) + " \\"

            lines = [
                '#!/usr/bin/env bash',
                '# Generated by Appify – Firefox kiosk mode',
                'set -euo pipefail',
                'source "$HOME/.profile" 2>/dev/null || true',
                '',
                f'CONFIG_DIR={shlex.quote(str(CONFIG_DIR))}',
                f'LOG_FILE={shlex.quote(str(LOG_FILE))}',
                'exec 2>>"$LOG_FILE"',
                'set -x',
                '',
                f'NICE_CMD="nice -n {nice}"',
                f'IONICE_CMD="ionice -c {ionice}"',
                f'PROFILE_DIR={shlex.quote(str(profile_dir))}',
                f'URL={shlex.quote(app_url)}',
                f'export GTK_APPLICATION_ID={shlex.quote(unique_wm_class)}',
                # MOZ_APP_REMOTINGNAME tells Firefox what WM_CLASS / Wayland
                # app_id to report.  Without this it defaults to "firefox" after
                # startup, which causes the panel to revert to the Firefox icon.
                # The value must match StartupWMClass in the .desktop file, which
                # is set to the profile directory basename (slug).
                f'export MOZ_APP_REMOTINGNAME={shlex.quote(slug)}',
                '',
                exec_line,
                '  --profile="$PROFILE_DIR" \\',
                '  --no-remote \\',
                '  --kiosk \\',
                '  "$URL"',
            ]
            wrapper_content = '\n'.join(lines)
            try:
                wrapper.write_text(wrapper_content)
                wrapper.chmod(0o755)
            except Exception as exc:
                _logger.error("Error writing wrapper script: %s", exc)
            return wrapper

        cmd_quoted = shlex.quote(cmd)
        exec_cmd = f'$NICE_CMD $IONICE_CMD {cmd_quoted} {args}'
        if chromium_based:
            exec_cmd += f' {wm_class_arg}'

    # For non-kiosk Firefox on Wayland, inject MOZ_ENABLE_WAYLAND in the script header
    if browser_key == "firefox" and get_session_type() == "wayland":
        compositor = detect_wayland_compositor()
        firefox_wayland_env = "export MOZ_ENABLE_WAYLAND=1\n"
        if compositor == "kde":
            firefox_wayland_env += "export GTK_USE_PORTAL=1\n"

    # Always export MOZ_APP_REMOTINGNAME for Firefox so the WM_CLASS / Wayland
    # app_id matches the profile directory basename (slug), which is what
    # StartupWMClass in the .desktop file is set to.  Without this the panel
    # reverts to the Firefox icon once the browser fully loads, regardless of
    # GTK_APPLICATION_ID.  Applies to native, Snap, and Flatpak installs.
    if browser_key == "firefox":
        firefox_wayland_env += f"export MOZ_APP_REMOTINGNAME={shlex.quote(slug)}\n"

    session_type = get_session_type()

    lines = [
        '#!/usr/bin/env bash',
        '# Generated by Appify',
        f'# Session: {session_type}',
        f'# Compositor: {detect_wayland_compositor() if session_type == "wayland" else "n/a"}',
        f'# Browser: {browser_detection["display_name"]}',
        'set -euo pipefail',
        'source "$HOME/.profile" 2>/dev/null || true',
        '',
        f'CONFIG_DIR={shlex.quote(str(CONFIG_DIR))}',
        f'LOG_FILE={shlex.quote(str(LOG_FILE))}',
        'exec 2>>"$LOG_FILE"',
        'set -x',
        '',
        f'NICE_CMD="nice -n {nice}"',
        f'IONICE_CMD="ionice -c {ionice}"',
        f'export GTK_APPLICATION_ID={shlex.quote(unique_wm_class)}',
        *([firefox_wayland_env.rstrip('\n')] if firefox_wayland_env.strip() else []),
        f"exec setsid {exec_cmd}",
    ]

    wrapper_content = '\n'.join(lines)

    try:
        wrapper.write_text(wrapper_content)
        wrapper.chmod(0o755)
    except Exception as exc:
        _logger.error("Error writing wrapper script: %s", exc)

    return wrapper

def create_desktop_file(app: dict, script_path: str, status_callback=None):
    """
    Writes the .desktop file for a PWA.

    Firefox WM-class note (affects taskbar icon grouping):
      Firefox derives its window WM_CLASS from the *profile directory name*,
      not from any command-line flag.  When launched with
        --profile ~/.pwa_manager/profiles/pwa-claude
      Firefox sets WM_CLASS to ("pwa-claude", "firefox") on X11 and the same
      app_id on Wayland.  StartupWMClass in the .desktop file must therefore
      match the profile directory basename, not an arbitrary "PWA-<slug>".

      For Chromium-based browsers we keep the "PWA-<slug>" class because those
      browsers honour --class/--name flags directly.

    Icon= uses the full absolute path so KDE Wayland (and other compositors)
    find the icon without needing a warm icon-theme cache.
    """
    desktop_path = get_desktop_file_path(app)
    icon_path = get_icon_path(app)
    app_name = sanitize_shell_string(app["name"])
    slug = slugify(app["name"])

    profile_cfg = load_profile_config(app)
    browser_key = (profile_cfg.get('browser') or app.get('browser') or CONFIG.get('browser', 'firefox')).lower()

    nice_val   = profile_cfg.get('nice',   CONFIG.get('nice',   0))
    ionice_val = profile_cfg.get('ionice', CONFIG.get('ionice', 2))
    gpu = CONFIG.get('gpu', True)
    browser_detection = detect_browser_installation(browser_key)
    wrapper = make_launcher_wrapper(app, browser_key, nice_val, ionice_val, gpu)

    try_exec = browser_detection.get('cmd', '').split()[0] if browser_detection['type'] != 'not_found' else str(wrapper)

    # Firefox derives WM_CLASS / Wayland app_id from the profile directory
    # basename — e.g. "pwa-claude" — regardless of any flag.  The desktop file
    # must match that exact string or the panel reverts to the Firefox icon.
    # Chromium browsers honour --class/--name so we use our own "PWA-<slug>".
    chromium_based_desktop = browser_key in [
        "edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"
    ]
    startup_wm_class = f"PWA-{slug}" if chromium_based_desktop else slug

    dbus_name = f"com.pwa.{slug}"

    icon_value = str(icon_path.resolve()) if icon_path.exists() else "web-browser"

    desktop_content = (
        "[Desktop Entry]\n"
        "Version=1.0\n"
        "Type=Application\n"
        f"Name={app_name}\n"
        f"Exec={str(wrapper)}\n"
        f"TryExec={try_exec}\n"
        f"Icon={icon_value}\n"
        "Terminal=false\n"
        "Categories=Network;WebBrowser;\n"
        "StartupNotify=true\n"
        f"X-GNOME-FullName={app_name} PWA\n"
        f"StartupWMClass={startup_wm_class}\n"
        f"X-DBus-Name={dbus_name}\n"
    )

    try:
        DESKTOP_DIR.mkdir(parents=True, exist_ok=True)
        desktop_path.write_text(desktop_content)
        desktop_path.chmod(0o755)
        subprocess.run(["update-desktop-database", str(DESKTOP_DIR)], check=False, timeout=10)
        # Refresh the GTK icon theme cache so desktops that use the cache
        # (GNOME Shell, Cinnamon, XFCE …) also see the new icon immediately.
        # ICON_DIR is  …/hicolor/512x512/apps/  → parents[1] is the hicolor theme root.
        try:
            icon_theme_root = ICON_DIR.parents[1]
            subprocess.run(
                ["gtk-update-icon-cache", "-f", "-t", str(icon_theme_root)],
                check=False,
                capture_output=True,
                timeout=5,
            )
        except Exception as cache_exc:
            _logger.debug("gtk-update-icon-cache failed (non-fatal): %s", cache_exc)
        if status_callback:
            status_callback(f"Desktop: {app_name}")
    except Exception as e:
        if status_callback:
            status_callback(f"Desktop failed: {e}")


# ---------------- Config Paths ----------------
# Declared here so that save_config() and all helper functions that reference
# these paths can see them.  Functions defined above use these names at *call*
# time (not at definition time), so forward references are safe — but grouping
# the declarations near save_config() makes the dependency obvious to readers.
CONFIG_DIR  = Path(os.path.expanduser("~/.pwa_manager"))
CONFIG_FILE = CONFIG_DIR / "config.json"
ICON_DIR    = Path(os.path.expanduser("~/.local/share/icons/hicolor/512x512/apps/"))
DESKTOP_DIR = Path(os.path.expanduser("~/.local/share/applications/"))
LOG_FILE    = CONFIG_DIR / "launch.log"


def save_config():
    """
    Writes the current CONFIG dictionary to the config file atomically.

    Strategy:
      1. Serialise to JSON in memory.
      2. Write to a sibling .tmp file in the same directory (same filesystem,
         so rename is atomic on POSIX).
      3. Set permissions to 0o600 (owner-only read/write) before renaming so
         that the live file is never world-readable even for a brief moment.
      4. Atomically rename .tmp → live file.

    This prevents a partial write (e.g. from a crash or signal) from leaving
    the config file in a truncated / corrupt state.
    """
    CONFIG_DIR.mkdir(parents=True, exist_ok=True)
    tmp_path = CONFIG_FILE.with_suffix(".json.tmp")
    try:
        payload = json.dumps(CONFIG, indent=2)
        tmp_path.write_text(payload, encoding="utf-8")
        # Restrict permissions before the file becomes live.
        tmp_path.chmod(0o600)
        tmp_path.rename(CONFIG_FILE)
    except Exception as exc:
        _logger.error("save_config failed: %s", exc)
        tmp_path.unlink(missing_ok=True)
        raise


PRESET_DOMAIN_MAP = {
    # Cloud Gaming
    "xbox.com": "Xbox Cloud Gaming",
    "geforcenow.com": "GeForce NOW",
    "luna.amazon.com": "Amazon Luna",
    "boosteroid.com": "Boosteroid",

    # =================== AI & Search ===================
    "chatgpt.com": "ChatGPT",
    "claude.ai": "Claude",
    "x.ai": "Grok",
    "gemini.google.com": "Gemini",
    "perplexity.ai": "Perplexity",

    # =================== Productivity & Daily Work ===================
    "mail.google.com": "Gmail",
    "calendar.google.com": "Google Calendar",
    "keep.google.com": "Google Keep",
    "drive.google.com": "Google Drive",
    "docs.google.com": "Google Docs",
    "docs.google.com/spreadsheets": "Google Sheets",
    "docs.google.com/presentation": "Google Slides",
    "office.com": "Microsoft 365",
    "outlook.live.com": "Outlook Web",
    "onedrive.live.com": "OneDrive",
    "notion.so": "Notion",
    "clickup.com": "ClickUp",
    "trello.com": "Trello",
    "todoist.com": "Todoist",
    "ticktick.com": "TickTick",
    "miro.com": "Miro",
    "canva.com": "Canva",
    "lucid.app": "Lucidchart",
    "excalidraw.com": "Excalidraw",
    "diagrams.net": "diagrams.net",

    # =================== Communication ===================
    "discord.com": "Discord",
    "slack.com": "Slack",
    "microsoft.com": "Microsoft Teams",   # covers teams.microsoft.com
    "zoom.us": "Zoom Web",
    "meet.google.com": "Google Meet",

    # =================== Social ===================
    "x.com": "X / Twitter",
    "reddit.com": "Reddit",
    "instagram.com": "Instagram",
    "facebook.com": "Facebook",
    "linkedin.com": "LinkedIn",
    "pinterest.com": "Pinterest",
    "bsky.app": "Bluesky",
    "5mind.com": "5MIND",

    # =================== Streaming ===================
    "youtube.com": "YouTube",
    "music.youtube.com": "YouTube Music",
    "netflix.com": "Netflix",
    "disneyplus.com": "Disney+",
    "primevideo.com": "Prime Video",
    "spotify.com": "Spotify Web",
    "twitch.tv": "Twitch",
    "crunchyroll.com": "Crunchyroll",
    "plex.tv": "Plex Web",
    "stremio.com": "Stremio Web",
    "hulu.com": "Hulu",
    "aniwatchtv.to": "AniWatch",
    "max.com": "Max (HBO)",
    "peacocktv.com": "Peacock",
    "paramountplus.com": "Paramount+",
    "tv.apple.com": "Apple TV+",
    "kick.com": "Kick",
    "rumble.com": "Rumble",
    "hianime.to": "Hianime",
    "capcut.com": "Capcut",

    # =================== Cloud Gaming ===================
    "airgpu.com": "AirGPU",

    # =================== Art & Creation ===================
    "photopea.com": "Photopea (Photoshop)",
    "figma.com": "Figma",
    "clipstudio.net": "Clip Studio Paint Web",
    "sketchfab.com": "Sketchfab",
    "pixlr.com": "Pixlr Editor",
    "remove.bg": "Remove.bg",

    # =================== VTuber & Streaming Tools ===================
    "streamlabs.com": "Streamlabs OBS Web",
    "ko-fi.com": "Ko-fi",
    "patreon.com": "Patreon",
    "throne.com": "Throne (Wishlist)",
    "streamelements.com": "Streamelements",
    "studio.youtube.com": "YouTube Studio",

    # =================== Utilities ===================
    "translate.google.com": "Google Translate",
    "deepl.com": "DeepL Translate",
    "speedtest.net": "Speedtest.net",
    "fast.com": "Fast.com",
    "pomofocus.io": "Pomofocus Timer",
    "mynoise.net": "myNoise.net",
    "rainymood.com": "Rainy Mood",
    "radio.garden": "Radio Garden",
    "ilovepdf.com": "ILovePDF",
    "tinypng.com": "TinyPNG",
    "khanacademy.org": "Khan Academy",
    "duolingo.com": "Duolingo",
    "yummly.com": "Yummly",
    "starbucks.com": "Starbucks Order",

    # =================== Shopping ===================
    "amazon.com": "Amazon",
    "ebay.com": "eBay",
    "aliexpress.com": "AliExpress",
    "walmart.com": "Walmart",
    "target.com": "Target",
    "bestbuy.com": "Best Buy",
    "etsy.com": "Etsy",
    "trivago.com": "Trivago",
    "uber.com": "Uber Web",

    # =================== News & Knowledge ===================
    "wikipedia.org": "Wikipedia",
    "bbc.com": "BBC News",
    "reuters.com": "Reuters",
    "theverge.com": "The Verge",
    "techcrunch.com": "TechCrunch",
    "ycombinator.com": "Hacker News",
    "wolframalpha.com": "Wolfram Alpha",
    "cnn.com": "CNN",
    "nytimes.com": "The New York Times",
    "washingtonpost.com": "The Washington Post",
    "forbes.com": "Forbes",
}



DEFAULT_EXT_PRESETS = {
    "Twitch": [
        {"name": "BetterTTV", "web_url": "https://chromewebstore.google.com/detail/betterttv/ajopnjidmegmdimjlfnijceegpefgped"},
        {"name": "7TV", "web_url": "https://chromewebstore.google.com/detail/7tv/ammjkodgmmoknidbanneddgankgfejfh"},
    ],
    "Kick": [
        {"name": "NipahTV (Emotes + Chat Enhancements)", "web_url": "https://chromewebstore.google.com/detail/nipahtv/bjggmgekoncaaalaalhchepgkjoahjln"},
        {"name": "7TV", "web_url": "https://chromewebstore.google.com/detail/7tv/ammjkodgmmoknidbanneddgankgfejfh"},
    ],
    "YouTube": [
        {"name": "SponsorBlock", "web_url": "https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone"},
        {"name": "uBlock Origin", "web_url": "https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm"},
        {"name": "Return YouTube Dislike", "web_url": "https://chromewebstore.google.com/detail/return-youtube-dislike/gebbhagfogifgggkldgodflihgfeippi"},
    ],
    "Google Docs": [
        {"name": "Super Styles for Google Docs", "web_url": "https://workspace.google.com/u/0/marketplace/app/super_styles_for_google_docs/749048387655"},
        {"name": "Code Blocks for Google Docs", "web_url": "https://workspace.google.com/u/0/marketplace/app/code_blocks/100740430168"},
        {"name": "Grammar and Spell Checker for Google Docs", "web_url": "https://workspace.google.com/u/0/marketplace/app/grammar_and_spell_checker_languagetool/805250893316"},
    ],
    "Google Calendar": [
        {"name": "Event Merge", "web_url": "https://chromewebstore.google.com/detail/event-merge-for-google-cal/dlifekfklhbcbgponifgpdbcopbekmna"},
    ],
}


DEFAULT_APPS = [
     # =================== AI & Search (2025 Essentials) ===================
    {"name": "ChatGPT", "url": "https://chatgpt.com", "kiosk": False},
    {"name": "Claude", "url": "https://claude.ai", "kiosk": False},
    {"name": "Grok", "url": "https://grok.x.ai", "kiosk": False},
    {"name": "Gemini", "url": "https://gemini.google.com", "kiosk": False},
    {"name": "Perplexity", "url": "https://perplexity.ai", "kiosk": False},

    # =================== Productivity & Daily Work ===================
    {"name": "Gmail", "url": "https://mail.google.com", "kiosk": False},
    {"name": "Google Calendar", "url": "https://calendar.google.com", "kiosk": False},
    {"name": "Google Keep", "url": "https://keep.google.com", "kiosk": False},
    {"name": "Google Drive", "url": "https://drive.google.com", "kiosk": False},
    {"name": "Google Docs", "url": "https://docs.google.com/document/", "kiosk": False},
    {"name": "Google Sheets", "url": "https://docs.google.com/spreadsheets/", "kiosk": False},
    {"name": "Google Slides", "url": "https://docs.google.com/presentation/", "kiosk": False},
    {"name": "Microsoft 365", "url": "https://www.office.com", "kiosk": False},
    {"name": "Outlook Web", "url": "https://outlook.live.com", "kiosk": False},
    {"name": "OneDrive", "url": "https://onedrive.live.com", "kiosk": False},
    {"name": "Notion", "url": "https://www.notion.so", "kiosk": False},
    {"name": "ClickUp", "url": "https://app.clickup.com", "kiosk": False},
    {"name": "Trello", "url": "https://trello.com", "kiosk": False},
    {"name": "Todoist", "url": "https://todoist.com", "kiosk": False},
    {"name": "TickTick", "url": "https://ticktick.com", "kiosk": False},
    {"name": "Miro", "url": "https://miro.com", "kiosk": False},
    {"name": "Canva", "url": "https://www.canva.com", "kiosk": False},
    {"name": "Lucidchart", "url": "https://lucid.app", "kiosk": False},
    {"name": "Excalidraw", "url": "https://excalidraw.com", "kiosk": False},
    {"name": "diagrams.net", "url": "https://app.diagrams.net", "kiosk": False},

    # =================== Communication (Everyone Uses) ===================
    {"name": "Discord", "url": "https://discord.com/app", "kiosk": False},
    {"name": "Slack", "url": "https://app.slack.com", "kiosk": False},
    {"name": "Microsoft Teams", "url": "https://teams.microsoft.com", "kiosk": False},
    {"name": "Zoom Web", "url": "https://zoom.us/join", "kiosk": False},
    {"name": "Google Meet", "url": "https://meet.google.com", "kiosk": False},

    # =================== Social (Mainstream) ===================
    {"name": "X / Twitter", "url": "https://x.com", "kiosk": False},
    {"name": "Reddit", "url": "https://www.reddit.com", "kiosk": False},
    {"name": "Instagram", "url": "https://www.instagram.com", "kiosk": False},
    {"name": "Facebook", "url": "https://www.facebook.com", "kiosk": False},
    {"name": "LinkedIn", "url": "https://www.linkedin.com", "kiosk": False},
    {"name": "Pinterest", "url": "https://www.pinterest.com", "kiosk": False},
    {"name": "Bluesky", "url": "https://bsky.app", "kiosk": False},
    {"name": "5MIND", "url": "https://5mind.com/", "kiosk": False},

    # =================== Streaming & Entertainment (Big Ones) ===================
    {"name": "YouTube", "url": "https://www.youtube.com", "kiosk": False},
    {"name": "YouTube Music", "url": "https://music.youtube.com", "kiosk": False},
    {"name": "Netflix", "url": "https://www.netflix.com", "kiosk": False},
    {"name": "Disney+", "url": "https://www.disneyplus.com", "kiosk": False},
    {"name": "Prime Video", "url": "https://www.primevideo.com", "kiosk": False},
    {"name": "Spotify Web", "url": "https://open.spotify.com", "kiosk": False},
    {"name": "Twitch", "url": "https://www.twitch.tv", "kiosk": False},
    {"name": "Crunchyroll", "url": "https://www.crunchyroll.com", "kiosk": False},
    {"name": "Plex Web", "url": "https://app.plex.tv", "kiosk": False},
    {"name": "Stremio Web", "url": "https://web.stremio.com", "kiosk": False},
    {"name": "Hulu", "url": "https://www.hulu.com", "kiosk": False},
    {"name": "AniKai", "url": "https://anikai.to/", "kiosk": False},
    {"name": "Max (HBO)", "url": "https://max.com", "kiosk": False},
    {"name": "Peacock", "url": "https://www.peacocktv.com", "kiosk": False},
    {"name": "Paramount+", "url": "https://www.paramountplus.com", "kiosk": False},
    {"name": "Apple TV+", "url": "https://tv.apple.com", "kiosk": False},
    {"name": "Kick", "url": "https://kick.com", "kiosk": False},
    {"name": "Rumble", "url": "https://rumble.com", "kiosk": False},
    {"name": "Hianime", "url": "https://hianime.to/", "kiosk": False},
    {"name": "Capcut", "url": "https://www.capcut.com/", "kiosk": False},

    # =================== Gaming & Cloud Gaming (Actively Working 2025) ===================
    # Xbox uses Chromium (Edge/Brave/Chrome) for best WebHID gamepad support.
    {"name": "Xbox Cloud Gaming", "url": "https://www.xbox.com/play", "kiosk": True, "gamepad": True},
    # The rest work best with Firefox.
    {"name": "GeForce NOW",  "url": "https://play.geforcenow.com", "kiosk": True, "browser": "firefox"},
    {"name": "Amazon Luna",  "url": "https://luna.amazon.com",     "kiosk": True, "browser": "firefox"},
    {"name": "Boosteroid",   "url": "https://boosteroid.com/go",   "kiosk": True, "browser": "firefox"},
    {"name": "AirGPU",       "url": "https://airgpu.com",          "kiosk": True, "browser": "firefox"},

    # =================== Art, Design & Creation ===================
    {"name": "Photopea (Photoshop)", "url": "https://www.photopea.com", "kiosk": False},
    {"name": "Figma", "url": "https://www.figma.com", "kiosk": False},
    {"name": "Clip Studio Paint Web", "url": "https://www.clipstudio.net", "kiosk": False},
    {"name": "Sketchfab", "url": "https://sketchfab.com", "kiosk": False},
    {"name": "Pixlr Editor", "url": "https://pixlr.com", "kiosk": False},
    {"name": "Remove.bg", "url": "https://www.remove.bg", "kiosk": False},

    # =================== VTuber & Streaming Tools ===================
    {"name": "Streamlabs OBS Web", "url": "https://streamlabs.com", "kiosk": False},
    {"name": "Ko-fi", "url": "https://ko-fi.com", "kiosk": False},
    {"name": "Patreon", "url": "https://www.patreon.com", "kiosk": False},
    {"name": "Throne (Wishlist)", "url": "https://throne.com", "kiosk": False},
    {"name": "Streamelements", "url": "https://streamelements.com", "kiosk": False},
    {"name": "Streamlabs Dashboard", "url": "https://streamlabs.com/dashboard", "kiosk": False},
    {"name": "YouTube Studio", "url": "https://studio.youtube.com", "kiosk": False},

    # =================== Utilities Everyone Needs ===================
    {"name": "Google Translate", "url": "https://translate.google.com", "kiosk": False},
    {"name": "DeepL Translate", "url": "https://www.deepl.com/translator", "kiosk": False},
    {"name": "Speedtest.net", "url": "https://www.speedtest.net", "kiosk": False},
    {"name": "Fast.com", "url": "https://fast.com", "kiosk": False},
    {"name": "Pomofocus Timer", "url": "https://pomofocus.io", "kiosk": False},
    {"name": "myNoise.net", "url": "https://mynoise.net", "kiosk": False},
    {"name": "Rainy Mood", "url": "https://www.rainymood.com", "kiosk": False},
    {"name": "Radio Garden", "url": "https://radio.garden", "kiosk": False},
    {"name": "ILovePDF", "url": "https://www.ilovepdf.com", "kiosk": False},
    {"name": "TinyPNG", "url": "https://tinypng.com", "kiosk": False},
    {"name": "Khan Academy", "url": "https://www.khanacademy.org", "kiosk": False},
    {"name": "Duolingo", "url": "https://www.duolingo.com", "kiosk": False},
    {"name": "Yummly (Recipes)", "url": "https://www.yummly.com", "kiosk": False},
    {"name": "Starbucks Order", "url": "https://app.starbucks.com", "kiosk": False},

    # =================== Shopping (Big Global Players) ===================
    {"name": "Amazon", "url": "https://www.amazon.com", "kiosk": False},
    {"name": "eBay", "url": "https://www.ebay.com", "kiosk": False},
    {"name": "AliExpress", "url": "https://www.aliexpress.com", "kiosk": False},
    {"name": "Walmart", "url": "https://www.walmart.com", "kiosk": False},
    {"name": "Target", "url": "https://www.target.com", "kiosk": False},
    {"name": "Best Buy", "url": "https://www.bestbuy.com", "kiosk": False},
    {"name": "Etsy", "url": "https://www.etsy.com", "kiosk": False},
    {"name": "Trivago", "url": "https://www.trivago.com", "kiosk": False},
    {"name": "Uber Web", "url": "https://m.uber.com", "kiosk": False},

    # =================== News & Knowledge ===================
    {"name": "Wikipedia", "url": "https://www.wikipedia.org", "kiosk": False},
    {"name": "BBC News", "url": "https://www.bbc.com/news", "kiosk": False},
    {"name": "Reuters", "url": "https://www.reuters.com", "kiosk": False},
    {"name": "The Verge", "url": "https://www.theverge.com", "kiosk": False},
    {"name": "TechCrunch", "url": "https://techcrunch.com", "kiosk": False},
    {"name": "Hacker News", "url": "https://news.ycombinator.com", "kiosk": False},
    {"name": "Wolfram Alpha", "url": "https://www.wolframalpha.com", "kiosk": False},
    {"name": "CNN", "url": "https://edition.cnn.com", "kiosk": False},
    {"name": "The New York Times", "url": "https://www.nytimes.com", "kiosk": False},
    {"name": "The Washington Post", "url": "https://www.washingtonpost.com", "kiosk": False},
    {"name": "Forbes", "url": "https://www.forbes.com", "kiosk": False},
]

DEFAULT_CONFIG = {
    "config_version": CONFIG_VERSION,
    "apps": {slugify(a["name"]): a for a in DEFAULT_APPS},
    "browser": None,  # Will be auto-detected
    "gpu": True,
    "kiosk": False,
    "nice": 0,
    "ionice": 2,
    "dark_mode": True,
    "session_type": None,  # Will be detected
    "available_browsers": {},  # Will be populated
    "browsers": {
        "firefox": {
            "args": "--profile={profile_dir} --no-remote {kiosk_flag} {url}",
            "kiosk_flag": "--kiosk",
            "app_mode": False,
            "ext_base": "https://addons.mozilla.org/en-US/firefox/addon/",
            "store_url": "https://addons.mozilla.org/en-US/firefox/", 
            "ext_dir": "extensions",
            "ext_suffix": ".xpi"
        },
        "edge": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://microsoftedge.microsoft.com/addons/detail/",
            "store_url": "https://microsoftedge.microsoft.com/addons/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
        "brave": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://chromewebstore.google.com/detail/",
            "store_url": "https://chromewebstore.google.com/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
        "vivaldi": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://chromewebstore.google.com/detail/",
            "store_url": "https://chromewebstore.google.com/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
        "chrome": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://chromewebstore.google.com/detail/",
            "store_url": "https://chromewebstore.google.com/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
        "chromium": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://chromewebstore.google.com/detail/",
            "store_url": "https://chromewebstore.google.com/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
        "opera": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://addons.opera.com/en/extensions/details/",
            "store_url": "https://addons.opera.com/en/",
            "ext_dir": "Extensions",
            "ext_suffix": ".nex",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events"
        },
        "ungoogled-chromium": {
            "args": "--user-data-dir={profile_dir} --app={url} {kiosk_flag}",
            "kiosk_flag": "--start-fullscreen",
            "app_mode": True,
            "ext_base": "https://chromewebstore.google.com/detail/",
            "store_url": "https://chromewebstore.google.com/", 
            "ext_dir": "Extensions",
            "ext_suffix": ".crx",
            "extra_flags": "--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist"
        },
    },
}

# Load config
CONFIG_DIR.mkdir(parents=True, exist_ok=True)
if CONFIG_FILE.exists():
    try:
        CONFIG = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))
    except Exception as _cfg_err:
        _logger.warning("Config load failed (%s) — using defaults", _cfg_err)
        CONFIG = DEFAULT_CONFIG.copy()
else:
    CONFIG = DEFAULT_CONFIG.copy()
    # New install: write a pristine config with restrictive permissions.
    try:
        payload = json.dumps(CONFIG, indent=2)
        CONFIG_FILE.write_text(payload, encoding="utf-8")
        CONFIG_FILE.chmod(0o600)
    except Exception:
        pass

# Detect system configuration
CONFIG["session_type"] = get_session_type()
CONFIG["available_browsers"] = scan_available_browsers()

# Always refresh default browser detection on startup
# This ensures we use the current system default, not a stale saved value
detected_default = get_default_browser()
CONFIG["browser"] = detected_default

# ── Config migration ─────────────────────────────────────────────────────────
# v1 → v2: "apps" changed from a list to a dict keyed by slug.
# We detect the old format and convert it once, then stamp config_version = 2.
_cfg_ver = CONFIG.get("config_version", 1)
if _cfg_ver < 2:
    apps_collection = CONFIG.get("apps", [])
    if not isinstance(apps_collection, dict):
        _logger.info("Migrating config v1 → v2: converting apps list to dict")
        CONFIG["apps"] = {
            slugify(app["name"]): app
            for app in apps_collection
            if isinstance(app, dict) and "name" in app
        }
    CONFIG["config_version"] = CONFIG_VERSION
    _logger.info("Config migration to v%d complete", CONFIG_VERSION)
elif not isinstance(CONFIG.get("apps"), dict):
    # Defensive: version stamp present but apps is somehow still a list.
    _logger.warning("apps field was not a dict despite config_version=%d — re-converting", _cfg_ver)
    apps_collection = CONFIG.get("apps", [])
    CONFIG["apps"] = {
        slugify(app["name"]): app
        for app in apps_collection
        if isinstance(app, dict) and "name" in app
    }

# Merge any new default apps that don't exist yet in this installation.
existing_names = {app["name"] for app in CONFIG["apps"].values()}
for app in DEFAULT_APPS:
    app_slug = slugify(app["name"])
    if app["name"] not in existing_names and app_slug not in CONFIG["apps"]:
        # Use a copy so DEFAULT_APPS entries are never mutated
        app_copy = app.copy()
        if "browser" not in app_copy:
            app_copy["browser"] = CONFIG["browser"]
        CONFIG["apps"][app_slug] = app_copy

CONFIG.setdefault("browsers", {})
for browser_key, default_data in DEFAULT_CONFIG["browsers"].items():
    if browser_key not in CONFIG["browsers"]:
        CONFIG["browsers"][browser_key] = default_data
    else:
        for key, value in default_data.items():
            CONFIG["browsers"][browser_key].setdefault(key, value)

CONFIG.setdefault("dark_mode", True)

# Detect compositor and store it
CONFIG["wayland_compositor"] = detect_wayland_compositor() if is_wayland_session() else "n/a"

# Log detected configuration
_logger.info("Session: %s", CONFIG['session_type'])
if is_wayland_session():
    _logger.info("Compositor: %s", CONFIG['wayland_compositor'])
_logger.info("Default browser: %s", CONFIG['browser'])
_logger.info("Available browsers: %s", ', '.join(CONFIG['available_browsers'].keys()))

# Save once, after all runtime detections are complete
save_config()

# ---------------- Install/Uninstall ----------------

def init_firefox_profile(profile_dir: Path, app: dict):
    """
    Pre-initialises a Firefox profile directory so it behaves as an isolated PWA.

    Firefox only populates its profile with .db files and other data the first
    time the binary actually runs against that directory.  Without this seed
    file the profile folder is empty, the --no-remote guard fails to isolate
    it properly, and the PWA opens inside whatever Firefox window is already
    on screen instead of in its own dedicated instance.

    Writing user.js is the standard, documented way to pre-configure a Firefox
    profile.  Firefox reads it on every startup and copies every preference
    listed there into prefs.js, which is the live preferences file.  We set:

      • A unique profile name so the OS window list shows the app name.
      • browser.startup.homepage set to the PWA URL so it opens on first launch.
      • All first-run / welcome / telemetry / sync UI disabled — these would
        hijack the first window and break the PWA experience.
      • toolkit.singletonWindowType cleared so multiple isolated profiles can
        each open their own top-level window at the same time.
      • browser.tabs.warnOnClose / warnOnQuit disabled for clean exit.

    WM_CLASS / taskbar icon note:
      Firefox sets its WM_CLASS (X11) and Wayland app_id from the *remoting
      name*, which defaults to the profile directory basename (e.g. "pwa-claude").
      The wrapper script exports MOZ_APP_REMOTINGNAME=<slug> to make this
      explicit and consistent across native, Snap, and Flatpak installs.
      StartupWMClass in the .desktop file is set to the same slug so the panel
      can match the window to the correct icon.

    user.js is always rewritten on install so that profile updates (e.g. new
    preferences added in a later Appify version) are applied to existing profiles.
    Manual edits to user.js will be overwritten; users who need custom prefs
    should add them to a separate user-overrides.js instead.
    """
    profile_dir.mkdir(parents=True, exist_ok=True)

    app_name = app.get("name", "PWA")
    app_url  = app.get("url", "about:blank")
    slug     = slugify(app_name)

    # Escape backslash and double-quote so the values are safe inside the
    # double-quoted JS string literals written into user.js.
    def _js_str(s: str) -> str:
        return s.replace("\\", "\\\\").replace('"', '\\"')

    app_name_js = _js_str(app_name)
    app_url_js  = _js_str(app_url)
    slug_js     = _js_str(slug)

    user_js_content = f"""\
// Generated by Appify – do not edit by hand.
// This file is re-read by Firefox on every startup and merged into prefs.js.
// Add custom preferences to user-overrides.js instead of editing this file.

// ── Identity & WM class ───────────────────────────────────────────────────
// profile.name controls the window title shown in the OS task switcher.
user_pref("profile.name", "{app_name_js}");

// toolkit.mozApps.installer.hasSystemAddon forces Firefox to use the profile
// directory basename as its remoting/WM_CLASS name on X11 and Wayland.
// The explicit MOZ_APP_REMOTINGNAME env-var in the launcher wrapper is the
// primary mechanism; this pref is a belt-and-suspenders fallback.
user_pref("toolkit.winLastFocused", "{slug_js}");

// ── Startup ───────────────────────────────────────────────────────────────
// 0 = blank, 1 = home page, 2 = last session, 3 = resume previous session
user_pref("browser.startup.page", 1);
user_pref("browser.startup.homepage", "{app_url_js}");

// ── First-run / welcome UI (suppress completely) ───────────────────────
user_pref("browser.startup.firstrunSkipsHomepage", true);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
user_pref("startup.homepage_welcome_url.additional", "");
user_pref("startup.homepage_override_url", "");
user_pref("browser.laterrun.enabled", false);
user_pref("browser.uitour.enabled", false);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
user_pref("browser.aboutwelcome.enabled", false);

// ── New-tab page (keep it minimal, not a distraction) ─────────────────
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// ── Telemetry / data collection ────────────────────────────────────────
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.policy.firstRunURL", "");

// ── Sync / accounts (not needed for a PWA profile) ────────────────────
user_pref("identity.fxaccounts.enabled", false);

// ── Extension recommendations (noisy, irrelevant for PWA) ─────────────
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// ── Window behaviour ──────────────────────────────────────────────────
// Allows multiple independent Firefox profiles to each have their own
// top-level window open simultaneously (required for --no-remote).
user_pref("toolkit.singletonWindowType", "");
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.tabs.warnOnCloseOtherTabs", false);
user_pref("browser.warnOnQuit", false);
user_pref("browser.sessionstore.resume_from_crash", false);

// ── userChrome.css (custom Firefox UI styling) ───────────────────────
// Enable loading of userChrome.css from the chrome/ subdirectory of this
// profile.  Without this pref Firefox ignores the file entirely.
// This pref is set only when a userChrome.css has been selected in Appify;
// it is harmless to leave enabled even if the file is absent.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// ── GPU / rendering (prevents screen tearing on X11, especially Nvidia) ──
// Force hardware layers acceleration. Without this Firefox may fall back to
// software compositing on X11 Nvidia systems, causing tearing when playing
// video or scrolling rapidly.  This mirrors the behaviour users get in a
// regular browser profile but is not set by default in a new profile.
user_pref("layers.acceleration.force-enabled", true);
user_pref("layers.omtp.enabled", true);
// Allow WebRender on X11 (disabled by default on some driver/distro combos).
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.enabled", true);

// ── Security defaults (keep sensible values) ─────────────────────────
user_pref("security.sandbox.content.level", 2);
"""

    user_js_path = profile_dir / "user.js"
    # Always rewrite so that new preferences added in later Appify versions
    # are applied to existing profiles on reinstall.
    try:
        user_js_path.write_text(user_js_content, encoding="utf-8")
    except Exception as e:
        _logger.warning("Could not write user.js for Firefox profile: %s", e)

    # ── userChrome.css ────────────────────────────────────────────────────────
    # If the user selected a userChrome.css source file in the Appify UI, copy
    # it into <profile>/chrome/userChrome.css so Firefox picks it up on the
    # next launch.  The toolkit.legacyUserProfileCustomizations.stylesheets pref
    # written above is what makes Firefox actually load the file.
    profile_cfg = load_profile_config({"name": app.get("name", "")})
    css_source = profile_cfg.get("userchrome_css_source", "")
    chrome_dir = profile_dir / "chrome"
    chrome_css_dest = chrome_dir / "userChrome.css"

    if css_source:
        src = Path(css_source)
        if src.is_file():
            try:
                chrome_dir.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src, chrome_css_dest)
                _logger.info("Installed userChrome.css from %s → %s", src, chrome_css_dest)
            except Exception as css_exc:
                _logger.warning("Could not copy userChrome.css: %s", css_exc)
        else:
            _logger.warning(
                "userChrome.css source not found (skipping): %s", css_source
            )


def install_app(app, browser_key, kiosk, nice, ionice, gpu, status_callback=None):
    # ── Ensure app has a name ──────────────────────────────────────────────
    if 'url' in app and ('name' not in app or not app['name']):
        parsed_url = urlparse(app['url'])
        app['name'] = parsed_url.netloc or 'Custom PWA'

    # ── Validate URL before doing anything ────────────────────────────────
    if not validate_url(app.get('url', '')):
        if status_callback:
            status_callback(f"Error: invalid or insecure URL: {app.get('url', '')!r}")
        return

    app_slug = slugify(app["name"])

    # ── Verify browser is available ───────────────────────────────────────
    detection = detect_browser_installation(browser_key)
    if detection['type'] == 'not_found':
        if status_callback:
            status_callback(f"Error: {browser_key} is not installed")
        return

    profile_dir = get_profile_dir(app)
    profile_dir.mkdir(parents=True, exist_ok=True)
    try:
        profile_dir.chmod(0o700)
    except Exception:
        pass

    # Firefox needs its profile directory pre-seeded with a user.js so that
    # it launches as a proper isolated PWA instance.
    if browser_key.lower() == "firefox":
        init_firefox_profile(profile_dir, app)
        if status_callback:
            status_callback(f"Firefox profile initialised for {app['name']}")

    profile_cfg = load_profile_config(app)
    profile_cfg["browser"] = browser_key.lower()
    profile_cfg["gamepad"] = app.get("gamepad", False)
    profile_cfg["browser_type"] = detection['type']
    save_profile_config(app, profile_cfg)
    marker = profile_dir / "installed.marker"
    marker.write_text("installed\n")
    download_icon(app, status_callback)
    create_desktop_file(app, os.path.abspath(sys.argv[0]), status_callback)

    if app_slug not in CONFIG["apps"]:
        CONFIG["apps"][app_slug] = app

    save_config()

    if status_callback:
        status_callback(f"Installed: {app['name']} ({detection['display_name']})")

def remove_app_files(app_to_remove):
    app_slug = slugify(app_to_remove['name'])
    
    scripts_dir = CONFIG_DIR / "scripts"
    wrapper = scripts_dir / f"pwa-launch-{app_slug}.sh"
    wrapper.unlink(missing_ok=True)
    
    profile_dir = get_profile_dir(app_to_remove)
    marker = profile_dir / "installed.marker"
    desktop_path = get_desktop_file_path(app_to_remove)
    icon_path = get_icon_path(app_to_remove)
    
    marker.unlink(missing_ok=True)
    desktop_path.unlink(missing_ok=True)
    icon_path.unlink(missing_ok=True)
    
    subprocess.run(["update-desktop-database", "-q", str(DESKTOP_DIR)], check=False, timeout=10)

def uninstall_app(name):
    app_slug = slugify(name)
    app_to_remove = CONFIG["apps"].pop(app_slug, None)
        
    if app_to_remove:
        remove_app_files(app_to_remove)
        save_config() 

def list_installed_apps():
    profiles_root = CONFIG_DIR / "profiles"
    installed = []
    if profiles_root.is_dir():
        for p in profiles_root.iterdir():
            if p.is_dir() and (p / "installed.marker").exists():
                installed.append(p.name)
    return installed

BACKUP_DIR = CONFIG_DIR / ".backup"
MAX_BACKUPS_PER_APP = 10  # Oldest backups are pruned beyond this limit.

def _backup_timestamp() -> str:
    """ISO-ish timestamp safe for filenames."""
    return datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

def backup_profile(app: dict, status_callback=None) -> Path | None:
    """
    Creates a timestamped .tar.gz snapshot of a single app's profile inside
    BACKUP_DIR/<app-slug>/.

    The archive contains:
      • The entire browser profile directory (cookies, prefs, extensions …)
      • The app's profile.json
      • The app's launcher wrapper script (if present)
      • The app's .desktop file (if present)
      • The app's icon (if present)

    Old backups beyond MAX_BACKUPS_PER_APP are pruned (oldest first).
    Returns the path to the created archive, or None on failure.
    """
    slug = slugify(app["name"])
    app_backup_dir = BACKUP_DIR / slug
    app_backup_dir.mkdir(parents=True, exist_ok=True)

    ts      = _backup_timestamp()
    archive = app_backup_dir / f"{slug}_backup_{ts}.tar.gz"

    try:
        with tarfile.open(archive, "w:gz") as tar:
            # Profile directory
            profile_dir = get_profile_dir(app)
            if profile_dir.exists():
                tar.add(profile_dir, arcname=f"profile/{slug}")

            # Launcher wrapper
            wrapper = CONFIG_DIR / "scripts" / f"pwa-launch-{slug}.sh"
            if wrapper.exists():
                tar.add(wrapper, arcname=f"scripts/pwa-launch-{slug}.sh")

            # Desktop file
            desktop = get_desktop_file_path(app)
            if desktop.exists():
                tar.add(desktop, arcname=f"desktop/pwa-{slug}-manager.desktop")

            # Icon
            icon = get_icon_path(app)
            if icon.exists():
                tar.add(icon, arcname=f"icons/{slug}.png")

            # App metadata as a small JSON sidecar
            meta_bytes = json.dumps(app, indent=2).encode()
            info = tarfile.TarInfo(name="meta.json")
            info.size = len(meta_bytes)
            tar.addfile(info, io.BytesIO(meta_bytes))

        # ── Prune old backups beyond MAX_BACKUPS_PER_APP ─────────────────
        existing = sorted(
            app_backup_dir.glob("*.tar.gz"),
            key=lambda p: p.stat().st_mtime,
        )
        while len(existing) > MAX_BACKUPS_PER_APP:
            oldest = existing.pop(0)
            try:
                oldest.unlink()
                _logger.info("Pruned old backup: %s", oldest.name)
            except Exception as prune_exc:
                _logger.warning("Could not prune backup %s: %s", oldest.name, prune_exc)

        if status_callback:
            status_callback(f"Backup created: {archive.name}")
        return archive

    except Exception as exc:
        _logger.exception("backup_profile failed")
        if status_callback:
            status_callback(f"Backup failed: {exc}")
        return None

def list_backups(app: dict) -> list[dict]:
    """
    Returns a list of backup info dicts for *app*, sorted newest-first.
    Each dict has keys: 'path' (Path), 'name' (str), 'mtime' (float),
    'size_mb' (float).
    """
    slug = slugify(app["name"])
    app_backup_dir = BACKUP_DIR / slug
    if not app_backup_dir.exists():
        return []
    results = []
    for f in sorted(app_backup_dir.glob("*.tar.gz"), key=lambda p: p.stat().st_mtime, reverse=True):
        st = f.stat()
        results.append({
            "path":    f,
            "name":    f.name,
            "mtime":   st.st_mtime,
            "size_mb": round(st.st_size / 1_048_576, 2),
        })
    return results

def restore_profile(backup_path: Path, app: dict, status_callback=None) -> bool:
    """
    Restores a profile from a backup archive.

    Steps:
      1. Validate the archive path is inside BACKUP_DIR (prevents path traversal).
      2. Inspect every tar member for unsafe paths before extracting.
      3. Wipe the current profile directory, extract, and move files back.
      4. Regenerate the launcher wrapper and desktop file.

    Returns True on success.
    """
    slug = slugify(app["name"])

    # ── Guard: backup_path must live under BACKUP_DIR ───────────────────────
    try:
        backup_path.resolve().relative_to(BACKUP_DIR.resolve())
    except ValueError:
        msg = f"Restore rejected: path outside backup dir: {backup_path}"
        _logger.error(msg)
        if status_callback:
            status_callback("Restore failed: invalid backup path")
        return False

    def _safe_member(member: tarfile.TarInfo, dest: Path) -> bool:
        """
        Returns True if *member* is safe to extract into *dest*.

        Rejects:
          • Absolute paths  (e.g. /etc/passwd)
          • Path-traversal  (e.g. ../../etc/passwd)
          • Symlinks / hard-links that escape dest
          • Device / FIFO / character-special files
        """
        # Normalise and check for traversal
        member_path = Path(member.name)
        if member_path.is_absolute():
            return False
        try:
            (dest / member_path).resolve().relative_to(dest.resolve())
        except ValueError:
            return False
        # Reject device/FIFO/character-special files unconditionally.
        if member.isdev():
            return False
        # Validate symlinks and hard-links point inside dest.
        if member.issym() or member.islnk():
            link_target = Path(member.linkname) if member.linkname else Path()
            if link_target.is_absolute():
                return False
            try:
                (dest / member_path).parent.joinpath(link_target).resolve().relative_to(dest.resolve())
            except ValueError:
                return False
        return True

    try:
        with tempfile.TemporaryDirectory() as tmpdir:
            tmp = Path(tmpdir)

            with tarfile.open(backup_path, "r:gz") as tar:
                # Validate all members and build a safe-only list in one pass.
                # Reject the entire archive if any unsafe member is found so we
                # never extract a partial set from a tampered archive.
                all_members = tar.getmembers()
                unsafe = [m.name for m in all_members if not _safe_member(m, tmp)]
                if unsafe:
                    _logger.error("Unsafe tar members rejected: %s", unsafe)
                    if status_callback:
                        status_callback("Restore failed: archive contains unsafe paths")
                    return False
                safe_members = [m for m in all_members if _safe_member(m, tmp)]
                # Use filter="data" on Python 3.12+ for an extra stdlib-level
                # path-traversal guard on top of our own _safe_member check.
                import sys as _sys
                if _sys.version_info >= (3, 12):
                    tar.extractall(tmp, members=safe_members, filter="data")
                else:
                    tar.extractall(tmp, members=safe_members)

            # --- Profile directory ---
            src_profile = tmp / "profile" / slug
            dst_profile = get_profile_dir(app)
            if src_profile.exists():
                if dst_profile.exists():
                    shutil.rmtree(dst_profile)
                shutil.copytree(src_profile, dst_profile)
                try:
                    dst_profile.chmod(0o700)
                except Exception:
                    pass

            # --- Launcher wrapper ---
            src_wrapper = tmp / "scripts" / f"pwa-launch-{slug}.sh"
            if src_wrapper.exists():
                dst_wrapper = CONFIG_DIR / "scripts" / f"pwa-launch-{slug}.sh"
                dst_wrapper.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src_wrapper, dst_wrapper)
                dst_wrapper.chmod(0o755)

            # --- Desktop file ---
            src_desktop = tmp / "desktop" / f"pwa-{slug}-manager.desktop"
            if src_desktop.exists():
                dst_desktop = get_desktop_file_path(app)
                dst_desktop.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src_desktop, dst_desktop)

            # --- Icon ---
            src_icon = tmp / "icons" / f"{slug}.png"
            if src_icon.exists():
                dst_icon = get_icon_path(app)
                dst_icon.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(src_icon, dst_icon)

        # Refresh the launcher wrapper with current settings in case paths changed.
        # Per-app nice/ionice from profile.json take priority over global defaults.
        profile_cfg = load_profile_config(app)
        browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()
        gpu        = CONFIG.get("gpu", True)
        nice_val   = profile_cfg.get("nice",   CONFIG.get("nice",   0))
        ionice_val = profile_cfg.get("ionice", CONFIG.get("ionice", 2))
        make_launcher_wrapper(app, browser_key, nice_val, ionice_val, gpu)
        create_desktop_file(app, os.path.abspath(sys.argv[0]))

        if status_callback:
            status_callback(f"Restored from {backup_path.name}")
        return True

    except Exception as exc:
        _logger.exception("restore_profile failed")
        if status_callback:
            status_callback(f"Restore failed: {exc}")
        return False

def delete_backup(backup_path: Path, status_callback=None) -> bool:
    """Permanently deletes a single backup archive."""
    try:
        backup_path.unlink()
        if status_callback:
            status_callback(f"Deleted backup: {backup_path.name}")
        return True
    except Exception as e:
        if status_callback:
            status_callback(f"Delete failed: {e}")
        return False

def find_app_by_name(name):
    for app in CONFIG["apps"].values():
        if app.get("name") == name:
            return app
    return None

def launch_app_from_cli(app_name: str):
    app = find_app_by_name(app_name)
    if not app:
        print(f"ERROR: App '{app_name}' not found.", file=sys.stderr)
        sys.exit(1)

    profile_cfg = load_profile_config(app)
    browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()

    detection = detect_browser_installation(browser_key)
    if detection['type'] == 'not_found':
        print(f"ERROR: Browser '{browser_key}' not found.", file=sys.stderr)
        sys.exit(1)

    gpu = CONFIG.get("gpu", True)
    # Per-app nice/ionice take priority over the global defaults so the wrapper
    # is regenerated with the same values that were set at install time.
    nice_val   = profile_cfg.get("nice",   CONFIG.get("nice",   0))
    ionice_val = profile_cfg.get("ionice", CONFIG.get("ionice", 2))

    try:
        wrapper = make_launcher_wrapper(app, browser_key, nice_val, ionice_val, gpu)

        # Security: confirm wrapper lives under CONFIG_DIR/scripts before executing it.
        expected_scripts_dir = (CONFIG_DIR / "scripts").resolve()
        try:
            wrapper.resolve().relative_to(expected_scripts_dir)
        except ValueError:
            log_debug(f"SECURITY: Wrapper path outside scripts dir: {wrapper}")
            print("ERROR: Wrapper path is outside the expected scripts directory.", file=sys.stderr)
            sys.exit(1)

        if not wrapper.exists():
            print(f"ERROR: Wrapper script not found: {wrapper}", file=sys.stderr)
            sys.exit(1)

        log_debug(f"LAUNCH: {app_name} via {detection['display_name']}")
        log_debug(f"WRAPPER: {wrapper}")

        subprocess.Popen(
            [str(wrapper)],
            start_new_session=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        sys.exit(0)

    except SystemExit:
        raise
    except Exception as exc:
        log_debug(f"LAUNCH ERROR: {exc}")
        print(f"Launch failed: {exc}", file=sys.stderr)
        sys.exit(1)

def launch_extension_manager(browser_key: str, preset_key: str, profile_dir: Path) -> bool:
    """
    Opens the browser to the extension store pages for *preset_key*.
    Returns True if the browser was launched successfully, False otherwise.
    """
    try:
        browser_config = get_browsers().get(browser_key)
        if not browser_config:
            _logger.error("Browser config not found for %s", browser_key)
            return

        detection = detect_browser_installation(browser_key)
        if detection['type'] == 'not_found':
            _logger.error("%s not installed", browser_key)
            return

        normalized_key = next(
            (k for k in DEFAULT_EXT_PRESETS.keys() if k.lower() == preset_key.lower()),
            preset_key,
        )
        extensions = DEFAULT_EXT_PRESETS.get(normalized_key, [])

        # Validate and filter extension URLs before passing to the browser.
        _ALLOWED_EXT_HOSTS = {
            "chromewebstore.google.com",
            "microsoftedge.microsoft.com",
            "addons.mozilla.org",
            "addons.opera.com",
            "workspace.google.com",
        }

        def _is_safe_ext_url(u: str) -> bool:
            if not validate_url(u):
                return False
            host = urlparse(u).netloc.lower().lstrip("www.")
            return any(host == h or host.endswith("." + h) for h in _ALLOWED_EXT_HOSTS)

        if not extensions:
            url = browser_config.get("store_url", "https://chromewebstore.google.com/")
            _logger.info(
                "No extensions for preset '%s'. Opening store: %s", preset_key, url
            )
            if detection['type'] == 'flatpak':
                flatpak_id = detection.get('flatpak_id', '')
                if not flatpak_id:
                    _logger.error("flatpak_id missing for %s", browser_key)
                    return False
                cmd_list = ["flatpak", "run", flatpak_id, url]
            elif detection['type'] == 'snap':
                snap_name = detection.get('snap_name', browser_key)
                cmd_list = ["snap", "run", snap_name, url]
            else:
                if browser_key.lower() == "firefox":
                    cmd_list = [detection['cmd'], "--profile", str(profile_dir), "--no-remote", url]
                else:
                    cmd_list = [detection['cmd'], f"--user-data-dir={str(profile_dir)}", url]
            subprocess.Popen(cmd_list)
            return True

        urls = [
            ext["web_url"]
            for ext in extensions
            if isinstance(ext.get("web_url"), str) and _is_safe_ext_url(ext["web_url"].strip())
        ]

        skipped = len(extensions) - len(urls)
        if skipped:
            _logger.warning(
                "%d extension URL(s) skipped — failed host allowlist check", skipped
            )

        if not urls:
            _logger.warning("No valid extension URLs for preset '%s'", preset_key)
            return False

        chromium_based_ext = browser_key.lower() in [
            "edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"
        ]

        if detection['type'] == 'flatpak':
            flatpak_id = detection.get('flatpak_id', '')
            if not flatpak_id:
                _logger.error("flatpak_id missing for %s", browser_key)
                return False
            cmd_list = ["flatpak", "run", flatpak_id]
            if chromium_based_ext:
                cmd_list.append("--new-window")
            cmd_list += urls
        elif detection['type'] == 'snap':
            snap_name = detection.get('snap_name', browser_key)
            cmd_list = ["snap", "run", snap_name]
            if chromium_based_ext:
                cmd_list.append("--new-window")
            cmd_list += urls
        else:
            if browser_key.lower() == "firefox":
                cmd_list = [detection['cmd'], "--profile", str(profile_dir), "--no-remote", "--new-window"] + urls
            else:
                cmd_list = [detection['cmd'], f"--user-data-dir={str(profile_dir)}", "--new-window"] + urls

        subprocess.Popen(cmd_list)
        _logger.info(
            "Launched %s to install extensions for '%s'.", detection['display_name'], preset_key
        )
        return True

    except Exception as exc:
        _logger.exception("launch_extension_manager error: %s", exc)
        return False


def _open_url_in_pwa_browser(browser_key: str, profile_dir: Path, url: str):
    """
    Opens *url* inside the PWA's own browser instance using its isolated profile,
    rather than delegating to xdg-open (which would use the system default browser).

    Mirrors the same detection + command-building logic used in launch_extension_manager.
    """
    if not validate_url(url):
        _logger.error("_open_url_in_pwa_browser: invalid URL '%s'", url)
        return

    detection = detect_browser_installation(browser_key)
    if detection['type'] == 'not_found':
        _logger.error("_open_url_in_pwa_browser: browser '%s' not installed", browser_key)
        return

    if detection['type'] == 'flatpak':
        flatpak_id = detection.get('flatpak_id', '')
        if not flatpak_id:
            _logger.error("_open_url_in_pwa_browser: flatpak_id missing for %s", browser_key)
            return
        cmd_list = ["flatpak", "run", flatpak_id, url]
    elif detection['type'] == 'snap':
        snap_name = detection.get('snap_name', browser_key)
        cmd_list = ["snap", "run", snap_name, url]
    else:
        if browser_key.lower() == "firefox":
            cmd_list = [detection['cmd'], "--profile", str(profile_dir), "--no-remote", url]
        else:
            cmd_list = [detection['cmd'], f"--user-data-dir={str(profile_dir)}", url]

    subprocess.Popen(cmd_list)
    _logger.info(
        "_open_url_in_pwa_browser: launched %s → %s", detection['display_name'], url
    )

# ---------------- GTK4 UI ----------------

class PWAManagerApp(Adw.Application):
    def __init__(self):
        super().__init__(application_id="com.appify", flags=Gio.ApplicationFlags.FLAGS_NONE)
        self.win = None
        self.sorted_apps_list = []

    def do_activate(self):
        if not self.win:
            self.win = PWAManagerWindow(application=self)
        self.win.present()

class PWAManagerWindow(Adw.ApplicationWindow):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        
        # Display session info in title
        compositor_val = CONFIG.get('wayland_compositor', 'n/a')
        session_display = (CONFIG.get('session_type') or 'unknown').upper()
        if is_wayland_session() and compositor_val not in ("n/a", "unknown"):
            session_display += f"/{compositor_val.title()}"
        session_info = f" • {session_display}" if CONFIG.get('session_type') else ""
        self.set_title(_("Appify %(version)s%(session)s") % {
            "version": CURRENT_VERSION,
            "session": session_info,
        })
        self.set_default_size(1000, 1050)
        self.sorted_apps_list = []

        self.statusbar = Gtk.Label()
        self.statusbar.set_xalign(0)
        self.statusbar.set_margin_top(10)
        self.statusbar.set_margin_start(10)

        header = Adw.HeaderBar()
        header.set_show_start_title_buttons(True)
        header.set_show_end_title_buttons(True)
        title = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        title.append(Gtk.Label(label=_("Appify %(version)s") % {"version": CURRENT_VERSION}))
        compositor_val = CONFIG.get('wayland_compositor', 'n/a')
        session_display = (CONFIG.get('session_type') or 'unknown').upper()
        if is_wayland_session() and compositor_val not in ("n/a", "unknown"):
            session_display += f" / {compositor_val.title()}"
        subtitle_text = f"Smart Browser Detection • {session_display} Session"
        title.append(Gtk.Label(label=subtitle_text))
        header.set_title_widget(title)

        menu_btn = Gtk.MenuButton()
        menu_btn.set_icon_name("open-menu-symbolic")
        menu = Gio.Menu()
        menu.append(_("About"), "win.about")
        menu.append(_("Rescan Browsers"), "win.rescan")
        menu.append(_("Restore Default Apps"), "win.restore_defaults")
        menu.append(_("Backup Manager"), "win.backup_manager")
        menu_btn.set_menu_model(menu)
        header.pack_end(menu_btn)

        about_action = Gio.SimpleAction.new("about", None)
        about_action.connect("activate", self.show_about_dialog)
        self.add_action(about_action)
        
        rescan_action = Gio.SimpleAction.new("rescan", None)
        rescan_action.connect("activate", self.on_rescan_browsers)
        self.add_action(rescan_action)
        
        restore_action = Gio.SimpleAction.new("restore_defaults", None)
        restore_action.connect("activate", self.on_restore_defaults)
        self.add_action(restore_action)

        backup_action = Gio.SimpleAction.new("backup_manager", None)
        backup_action.connect("activate", self.on_open_backup_manager)
        self.add_action(backup_action)

        mode_box = Gtk.Box(spacing=6)
        mode_box.append(Gtk.Label(label=_("Dark")))
        self.mode_switch = Gtk.Switch()
        self.mode_switch.set_active(CONFIG.get("dark_mode", True))
        self.mode_switch.connect("notify::active", self.on_mode_toggled)
        mode_box.append(self.mode_switch)
        header.pack_start(mode_box)

        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL)
        main_box.append(header)

        scroll = Gtk.ScrolledWindow()
        scroll.set_vexpand(True)
        scroll.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)

        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        content_box.set_margin_top(12)
        content_box.set_margin_bottom(12)
        content_box.set_margin_start(12)
        content_box.set_margin_end(12)
        scroll.set_child(content_box)
        main_box.append(scroll)
        self.set_content(main_box)

        # System info banner
        sys_info_frame = Gtk.Frame()
        sys_info_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        sys_info_box.set_margin_top(8)
        sys_info_box.set_margin_bottom(8)
        sys_info_box.set_margin_start(12)
        sys_info_box.set_margin_end(12)
        
        session_text = (CONFIG.get('session_type') or 'unknown').upper()
        compositor_val = CONFIG.get('wayland_compositor', 'n/a')
        if is_wayland_session() and compositor_val not in ("n/a", "unknown"):
            session_text += f" / {compositor_val.title()}"
        session_label = Gtk.Label()
        session_label.set_markup(f"<b>Display:</b> {session_text}")
        sys_info_box.append(session_label)
        
        browser_count = len(CONFIG.get('available_browsers', {}))
        browsers_label = Gtk.Label()
        browsers_label.set_markup(f"<b>Browsers Found:</b> {browser_count}")
        sys_info_box.append(browsers_label)
        
        default_browser = CONFIG.get('browser', 'unknown')
        default_label = Gtk.Label()
        default_label.set_markup(f"<b>Default:</b> {default_browser.title()}")
        sys_info_box.append(default_label)

        portal_status = check_webhid_portal()
        portal_label = Gtk.Label()
        portal_ok_str = "✓" if portal_status["ok"] else "✗"
        portal_label.set_markup(
            f"<b>WebHID Portal:</b> {portal_ok_str} {portal_status['portal']}"
        )
        portal_label.set_tooltip_text(portal_status["reason"])
        sys_info_box.append(portal_label)
        
        sys_info_frame.set_child(sys_info_box)
        content_box.append(sys_info_frame)

        search_frame = Gtk.Frame()
        search_frame.set_label_widget(Gtk.Label(label="<b>Search Apps</b>", use_markup=True))
        search_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        search_box.set_margin_top(12)
        search_box.set_margin_bottom(12)
        search_box.set_margin_start(12)
        search_box.set_margin_end(12)
        search_frame.set_child(search_box)
        
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text(_("Search apps..."))
        self.search_entry.connect("changed", self.on_search_changed)
        search_box.append(self.search_entry)
        content_box.append(search_frame)

        apps_frame = Gtk.Frame()
        apps_frame.set_label_widget(Gtk.Label(label="<b>PWA Selection</b>", use_markup=True))
        apps_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        apps_box.set_margin_top(12)
        apps_box.set_margin_bottom(12)
        apps_box.set_margin_start(12)
        apps_box.set_margin_end(12)
        apps_frame.set_child(apps_box)
        apps_box.append(Gtk.Label(label="Select App:", halign=Gtk.Align.START))
        
        factory = Gtk.SignalListItemFactory()
        factory.connect("setup", lambda f, item: item.set_child(Gtk.Label()))
        factory.connect("bind", lambda f, item: item.get_child().set_label(item.get_item().get_string()))
        
        self.app_combo = Gtk.DropDown(factory=factory)
        self.populate_app_combo()
        self.app_combo.connect("notify::selected", self.on_app_selected)
        apps_box.append(self.app_combo)
        content_box.append(apps_frame)

        options_frame = Gtk.Frame()
        options_frame.set_label_widget(Gtk.Label(label="<b>Options</b>", use_markup=True))
        options_grid = Gtk.Grid()
        options_grid.set_row_spacing(10)
        options_grid.set_column_spacing(12)
        options_grid.set_margin_top(12)
        options_grid.set_margin_bottom(12)
        options_grid.set_margin_start(12)
        options_grid.set_margin_end(12)
        options_frame.set_child(options_grid)

        options_grid.attach(Gtk.Label(label="URL:", halign=Gtk.Align.START), 0, 0, 1, 1)
        self.url_entry = Gtk.Entry()
        self.url_entry.set_hexpand(True)
        options_grid.attach(self.url_entry, 1, 0, 2, 1)

        self.kiosk_check = Gtk.CheckButton(label="Kiosk Mode")
        self.kiosk_check.set_active(CONFIG.get("kiosk", False))
        options_grid.attach(self.kiosk_check, 0, 1, 1, 1)

        self.gpu_check = Gtk.CheckButton(label="GPU Acceleration")
        self.gpu_check.set_active(CONFIG.get("gpu", True))
        options_grid.attach(self.gpu_check, 1, 1, 1, 1)

        self.gamepad_check = Gtk.CheckButton(label="WebHID Gamepad")
        self.gamepad_check.set_active(False)
        self.gamepad_check.set_tooltip_text(
            "Enhanced WebHID for cloud gaming (Chromium browsers only).\n"
            "Requires xdg-desktop-portal + a DE-specific backend for device-permission dialogs."
        )
        self.gamepad_check.connect("toggled", self._on_gamepad_toggled)
        options_grid.attach(self.gamepad_check, 2, 1, 1, 1)

        options_grid.attach(Gtk.Label(label="Browser:", halign=Gtk.Align.START), 0, 2, 1, 1)
        
        self.browser_model = Gio.ListStore.new(Gtk.StringObject)
        self.browser_combo = Gtk.DropDown.new(self.browser_model, None)
        self.refresh_browser_combo()
        self.browser_combo.connect("notify::selected", self.on_browser_changed)
        options_grid.attach(self.browser_combo, 1, 2, 2, 1)

        content_box.append(options_frame)

        # ── Firefox-only Advanced Options ─────────────────────────────────────
        # This frame is shown/hidden dynamically based on the selected browser.
        self.firefox_advanced_frame = Gtk.Frame()
        self.firefox_advanced_frame.set_label_widget(
            Gtk.Label(label="<b>Firefox Advanced Options</b>", use_markup=True)
        )
        ff_adv_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        ff_adv_box.set_margin_top(12)
        ff_adv_box.set_margin_bottom(12)
        ff_adv_box.set_margin_start(12)
        ff_adv_box.set_margin_end(12)
        self.firefox_advanced_frame.set_child(ff_adv_box)

        # userChrome.css row
        chrome_css_label = Gtk.Label(
            label="<b>userChrome.css</b> — Customise Firefox's own UI (toolbars, menus, etc.).",
            use_markup=True,
            halign=Gtk.Align.START,
            wrap=True,
        )
        ff_adv_box.append(chrome_css_label)

        chrome_css_hint = Gtk.Label(
            label="Import a userChrome.css file to apply per-app Firefox UI tweaks.\n"
                  "The file is copied into the app's profile and activated automatically.",
            halign=Gtk.Align.START,
            wrap=True,
        )
        chrome_css_hint.add_css_class("caption")
        ff_adv_box.append(chrome_css_hint)

        chrome_css_row = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        self.chrome_css_path_label = Gtk.Label(
            label=_("No file selected"),
            halign=Gtk.Align.START,
            hexpand=True,
            ellipsize=3,  # Pango.EllipsizeMode.END
        )
        chrome_css_row.append(self.chrome_css_path_label)

        self.chrome_css_browse_btn = Gtk.Button(label=_("Browse…"))
        self.chrome_css_browse_btn.connect("clicked", self._on_browse_chrome_css)
        chrome_css_row.append(self.chrome_css_browse_btn)

        self.chrome_css_clear_btn = Gtk.Button(label=_("Clear"))
        self.chrome_css_clear_btn.connect("clicked", self._on_clear_chrome_css)
        chrome_css_row.append(self.chrome_css_clear_btn)

        ff_adv_box.append(chrome_css_row)

        # Track the selected path in an instance variable so it survives
        # between app selections and is written to profile.json at install time.
        self._chrome_css_source_path: str = ""

        content_box.append(self.firefox_advanced_frame)
        # Initially hidden; shown only when Firefox is the active browser.
        self.firefox_advanced_frame.set_visible(False)

        ext_frame = Gtk.Frame()
        ext_frame.set_label_widget(Gtk.Label(label="<b>Extensions</b>", use_markup=True))
        ext_vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        ext_vbox.set_margin_top(12)
        ext_vbox.set_margin_bottom(12)
        ext_vbox.set_margin_start(12)
        ext_vbox.set_margin_end(12)
        ext_frame.set_child(ext_vbox)

        self.ext_scroll = Gtk.ScrolledWindow()
        self.ext_scroll.set_hexpand(True)
        self.ext_scroll.set_vexpand(True)
        self.ext_scroll.set_min_content_height(150)
        self.ext_listbox = Gtk.ListBox()
        self.ext_scroll.set_child(self.ext_listbox)
        ext_vbox.append(self.ext_scroll)

        ext_btn_box = Gtk.Box(spacing=6)
        self.install_preset_btn = Gtk.Button(label="Install Presets")
        self.install_preset_btn.connect("clicked", self.on_install_presets)
        self.open_store_btn = Gtk.Button(label="Open Store")
        self.open_store_btn.connect("clicked", self.on_open_store)
        self.add_custom_ext_btn = Gtk.Button(label="Add Custom")
        self.add_custom_ext_btn.connect("clicked", self.on_add_custom_ext)
        for b in [self.install_preset_btn, self.open_store_btn, self.add_custom_ext_btn]:
            ext_btn_box.append(b)
        ext_vbox.append(ext_btn_box)

        content_box.append(ext_frame)

        perf_frame = Gtk.Frame()
        perf_frame.set_label_widget(Gtk.Label(label="<b>Performance Tuning</b>", use_markup=True))
        perf_grid = Gtk.Grid()
        perf_grid.set_row_spacing(10)
        perf_grid.set_column_spacing(12)
        perf_grid.set_margin_top(12)
        perf_grid.set_margin_bottom(12)
        perf_grid.set_margin_start(12)
        perf_grid.set_margin_end(12)
        perf_frame.set_child(perf_grid)
        
        nice_label = Gtk.Label(label="Nice Priority:", halign=Gtk.Align.START)
        nice_label.set_tooltip_text("CPU scheduling priority (-20 to 19, lower = higher priority)")
        perf_grid.attach(nice_label, 0, 0, 1, 1)
        
        self.nice_spin = Gtk.SpinButton()
        self.nice_spin.set_range(-20, 19)
        self.nice_spin.set_increments(1, 5)
        self.nice_spin.set_value(CONFIG.get("nice", 0))
        perf_grid.attach(self.nice_spin, 1, 0, 1, 1)
        
        ionice_label = Gtk.Label(label="I/O Priority:", halign=Gtk.Align.START)
        ionice_label.set_tooltip_text("I/O scheduling class (0=none, 1=realtime, 2=best-effort, 3=idle)")
        perf_grid.attach(ionice_label, 0, 1, 1, 1)
        
        self.ionice_spin = Gtk.SpinButton()
        self.ionice_spin.set_range(0, 3)
        self.ionice_spin.set_increments(1, 1)
        self.ionice_spin.set_value(CONFIG.get("ionice", 2))
        perf_grid.attach(self.ionice_spin, 1, 1, 1, 1)
        content_box.append(perf_frame)

        btn_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        btn_box.set_homogeneous(True)
        self.install_btn = Gtk.Button(label=_("Install"))
        self.install_btn.connect("clicked", self.on_install)
        self.install_custom_btn = Gtk.Button(label=_("Install Custom"))
        self.install_custom_btn.connect("clicked", self.on_install_custom)
        self.uninstall_btn = Gtk.Button(label=_("Uninstall"))
        self.uninstall_btn.connect("clicked", self.on_uninstall)
        self.clone_btn = Gtk.Button(label=_("Clone App"))
        self.clone_btn.connect("clicked", self.on_clone)
        self.refresh_btn = Gtk.Button(label=_("Refresh"))
        self.refresh_btn.connect("clicked", self.on_refresh)
        self.remove_btn = Gtk.Button(label=_("Delete App"))
        self.remove_btn.connect("clicked", self.on_remove_app)
        self.backup_btn = Gtk.Button(label=_("Backup"))
        self.backup_btn.connect("clicked", self.on_backup_profile)
        
        for b in [self.install_btn, self.install_custom_btn, self.uninstall_btn,
                  self.clone_btn, self.refresh_btn, self.remove_btn, self.backup_btn]: 
            if b in [self.install_btn, self.install_custom_btn]:
                b.add_css_class("suggested-action")
            elif b in [self.uninstall_btn, self.remove_btn]:
                b.add_css_class("destructive-action")
            btn_box.append(b)
        content_box.append(btn_box)
        content_box.append(self.statusbar)

        self.update_banner = Adw.Banner()
        self.update_banner.set_title("Update Available")
        self.update_banner.set_button_label("View Releases")
        self.update_banner.connect(
            "button-clicked",
            lambda b: subprocess.Popen(["xdg-open", "https://github.com/bobbycomet/Appify/releases"])
        )
        self.update_banner.set_revealed(False)
        content_box.append(self.update_banner)

        def show_update_message(msg):
            if not msg:
                return
            version_line = msg.split("\n")[0]
            GLib.idle_add(self.update_banner.set_title, version_line)
            GLib.idle_add(self.update_banner.set_revealed, True)
            self.status_push(_("Update available!"))

        GLib.timeout_add_seconds(2, lambda: check_for_updates(show_update_message) or False)

        self.style_manager = Adw.StyleManager.get_default()
        self.apply_color_scheme()

        if self.sorted_apps_list:
            self.app_combo.set_selected(0)
            self.populate_app_fields(self.sorted_apps_list[0])
        self.update_button_states()

    def show_about_dialog(self, action=None, param=None):
        available = CONFIG.get('available_browsers', {})
        browser_list = '\n'.join([f"• {info['display_name']}" for info in available.values()])
        
        about = Adw.AboutDialog(
            application_name=_("Appify"),
            application_icon="appify",
            developer_name="BobbyComet",
            version=CURRENT_VERSION,
            website="https://github.com/bobbycomet/Appify",
            issue_url="https://github.com/bobbycomet/Appify/issues",
            license_type=Gtk.License.GPL_3_0,
            copyright=_("© 2025 BobbyComet"),
            comments=_(
                "Progressive Web Apps with Smart Detection\n\n"
                f"Session: {(CONFIG.get('session_type') or 'unknown').upper()}\n"
                f"Default Browser: {CONFIG.get('browser', 'none').title()}\n"
                f"Config Version: {CONFIG.get('config_version', 1)}\n\n"
                f"Installed Browsers:\n{browser_list if browser_list else '• None detected'}"
            ),
            developers=["BobbyComet"],
        )
        about.add_link(_("Discord Community"), "https://discord.gg/7fEt5W7DPh")
        about.add_link(_("GitHub"), "https://github.com/bobbycomet/Appify")
        about.add_link(_("Support the project"), "https://ko-fi.com/bobby60908")

        SECURITY_POLICY = _(
        """Reporting a Vulnerability
        If you find a security issue, please do not open a public issue. Instead, please report it via:

        • Email: griffin.linux@gmail.com
        • Discord: https://discord.gg/7fEt5W7DPh

        Bounty Program
        As a solo developer, I do not currently offer financial bounties. However, I am happy to provide credit in the project's contributors list.

        How to Report
        1. Type of Issue: (e.g., Buffer overflow)
        2. Location: Which specific script or file?
        3. Step-by-Step Instructions: How to reproduce.
        4. Proof of Concept: Script or screenshot.
        5. Upstream Check: Does this exist in standard Ubuntu?""")

        about.add_legal_section(
            _("Security Policy"),
            SECURITY_POLICY,
            Gtk.License.UNKNOWN
        )
        about.present(self)

    def on_rescan_browsers(self, action=None, param=None):
        """Rescans for available browsers"""
        CONFIG["available_browsers"] = scan_available_browsers()
        CONFIG["browser"] = get_default_browser()
        save_config()
        self.refresh_browser_combo()
        
        browser_count = len(CONFIG['available_browsers'])
        self.status_push(_("Rescan complete: %(count)d browser(s) found") % {"count": browser_count})

    def on_restore_defaults(self, action=None, param=None):
        """Restores any missing default apps"""
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading="Restore Default Apps",
            body="This will restore any default apps that have been deleted.\n\nExisting apps will not be affected."
        )
        dialog.add_response("cancel", "Cancel")
        dialog.add_response("restore", "Restore")
        dialog.set_response_appearance("restore", Adw.ResponseAppearance.SUGGESTED)
        dialog.show()

        def on_response(dlg, resp):
            if resp == "restore":
                restored_count = 0
                existing_names = {app["name"] for app in CONFIG["apps"].values()}
                
                for default_app in DEFAULT_APPS:
                    app_slug = slugify(default_app["name"])
                    # Only add if both the name and slug don't exist
                    if default_app["name"] not in existing_names and app_slug not in CONFIG["apps"]:
                        # Set browser to default if not specified
                        app_copy = default_app.copy()
                        if "browser" not in app_copy:
                            app_copy["browser"] = CONFIG["browser"]
                        CONFIG["apps"][app_slug] = app_copy
                        restored_count += 1
                
                if restored_count > 0:
                    save_config()
                    current_search = self.search_entry.get_text().strip()
                    self.populate_app_combo(current_search)
                    self.update_button_states()
                    self.status_push(f"Restored {restored_count} default app(s)")
                else:
                    self.status_push("All default apps are already present")
            dlg.close()
            
        dialog.connect("response", on_response)

    def get_selected_app(self):
        combo = self.app_combo
        selected_index = combo.get_selected()
        if selected_index != Gtk.INVALID_LIST_POSITION and selected_index < len(self.sorted_apps_list):
            return self.sorted_apps_list[selected_index]
        return None

    def apply_color_scheme(self):
        dark = CONFIG.get("dark_mode", True)
        self.style_manager.set_color_scheme(Adw.ColorScheme.FORCE_DARK if dark else Adw.ColorScheme.FORCE_LIGHT)
        self.mode_switch.set_active(dark)

    def on_mode_toggled(self, switch, _):
        dark = switch.get_active()
        CONFIG["dark_mode"] = dark
        save_config()
        self.apply_color_scheme()
        self.status_push(f"Switched to {'Dark' if dark else 'Light'} mode")

    def status_push(self, msg):
        GLib.idle_add(self.statusbar.set_text, msg)
        if hasattr(self, '_status_timeout_id') and self._status_timeout_id:
            GLib.source_remove(self._status_timeout_id)
        self._status_timeout_id = GLib.timeout_add_seconds(5, self._clear_status)

    def _clear_status(self):
        self.statusbar.set_text("")
        self._status_timeout_id = None
        return False  # Don't repeat

    def populate_app_combo(self, search_term=""):
        all_apps = CONFIG["apps"].values()

        if search_term:
            search_term_lower = search_term.lower()
            filtered_apps = [
                app for app in all_apps
                if search_term_lower in app["name"].lower()
            ]
        else:
            filtered_apps = list(all_apps)

        self.sorted_apps_list = sorted(filtered_apps, key=lambda x: x["name"].lower())

        installed: set[str] = set(list_installed_apps())
        strings = []
        for app in self.sorted_apps_list:
            name = app["name"]
            slug = slugify(name)
            text = f"✓ {name}" if slug in installed else name
            strings.append(text)

        model = Gio.ListStore.new(Gtk.StringObject)
        for s in strings:
            model.append(Gtk.StringObject.new(s))
        self.app_combo.set_model(model)

    def on_search_changed(self, entry):
        search_term = entry.get_text().strip()
        self.populate_app_combo(search_term)
        
        if self.sorted_apps_list:
            self.app_combo.set_selected(0)
            self.on_app_selected(self.app_combo, None) 
        else:
            self.app_combo.set_selected(Gtk.INVALID_LIST_POSITION)
            self.update_button_states()
            self.kiosk_check.set_active(False)
            self.gamepad_check.set_active(False)
            self.url_entry.set_text("")
            self.populate_extensions(None)

    def on_app_selected(self, combo, _):
        idx = combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION or idx >= len(self.sorted_apps_list):
            return
        app = self.sorted_apps_list[idx]
        self.populate_app_fields(app)
        self.populate_extensions(app)
        self.update_button_states()

    def populate_app_fields(self, app):
        self.url_entry.set_text(app.get("url", ""))
        self.kiosk_check.set_active(app.get("kiosk", False))
        self.gamepad_check.set_active(app.get("gamepad", False))
        
        profile_cfg = load_profile_config(app)
        browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()

        chromium_based = browser_key in ["edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"]
        self.gamepad_check.set_sensitive(chromium_based)
        if not chromium_based:
            self.gamepad_check.set_active(False)

        # Show per-app nice/ionice if set, otherwise show the global default.
        self.nice_spin.set_value(profile_cfg.get("nice",   CONFIG.get("nice",   0)))
        self.ionice_spin.set_value(profile_cfg.get("ionice", CONFIG.get("ionice", 2)))

        # Find browser in available list
        available_keys = list(CONFIG.get("available_browsers", {}).keys())
        try:
            idx = available_keys.index(browser_key)
            self.browser_combo.set_selected(idx)
        except ValueError:
            self.browser_combo.set_selected(0)

        # Restore the userChrome.css path saved in profile.json (if any).
        saved_css = profile_cfg.get("userchrome_css_source", "")
        self._chrome_css_source_path = saved_css
        self.chrome_css_path_label.set_text(saved_css if saved_css else _("No file selected"))

        # Show or hide the Firefox advanced frame based on the resolved browser.
        self._update_firefox_advanced_visibility(browser_key)

    def refresh_browser_combo(self):
        self.browser_model.remove_all()
        available = CONFIG.get("available_browsers", {})
        for key, info in available.items():
            self.browser_model.append(Gtk.StringObject.new(info['display_name']))

    def _on_gamepad_toggled(self, check):
        """
        Called when the WebHID Gamepad checkbox is toggled.

        If the user enables gamepad support, runs a quick portal check and
        shows an informational dialog if the xdg-desktop-portal stack is not
        ready, so the user knows why the browser may silently deny device access.
        Does NOT block the action — the user may still proceed.
        """
        if not check.get_active():
            return  # Unchecking never needs a warning.

        portal = check_webhid_portal()
        if portal["ok"]:
            self.status_push(f"WebHID: portal OK ({portal['portal']})")
            return

        # Show a non-blocking advisory dialog.
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading="WebHID Portal Not Ready",
            body=(
                f"{portal['reason']}\n\n"
                "You can still install with WebHID enabled — the browser flags "
                "will be set — but device-permission dialogs may not appear and "
                "gamepad access could be silently denied by the sandbox."
            ),
        )
        dialog.add_response("ok", "OK, understood")
        dialog.set_default_response("ok")
        dialog.show()
        dialog.connect("response", lambda d, _r: d.close())
        self.status_push(f"WebHID warning: {portal['portal']} not ready")

    # ── Firefox-only advanced option helpers ──────────────────────────────────

    def _update_firefox_advanced_visibility(self, browser_key: str):
        """Show the Firefox Advanced Options frame only when Firefox is selected."""
        is_firefox = browser_key.lower() == "firefox"
        self.firefox_advanced_frame.set_visible(is_firefox)

    def _on_browse_chrome_css(self, btn):
        """Opens a file-chooser dialog to select a userChrome.css file."""
        dialog = Gtk.FileChooserDialog(
            title=_("Select userChrome.css"),
            transient_for=self,
            action=Gtk.FileChooserAction.OPEN,
        )
        dialog.add_button(_("Cancel"), Gtk.ResponseType.CANCEL)
        dialog.add_button(_("Select"), Gtk.ResponseType.ACCEPT)

        css_filter = Gtk.FileFilter()
        css_filter.set_name(_("CSS files (*.css)"))
        css_filter.add_pattern("*.css")
        dialog.add_filter(css_filter)

        all_filter = Gtk.FileFilter()
        all_filter.set_name(_("All files"))
        all_filter.add_pattern("*")
        dialog.add_filter(all_filter)

        dialog.connect("response", self._on_chrome_css_dialog_response)
        dialog.show()

    def _on_chrome_css_dialog_response(self, dialog, response):
        if response == Gtk.ResponseType.ACCEPT:
            file = dialog.get_file()
            if file:
                path = file.get_path()
                if path:
                    self._chrome_css_source_path = path
                    self.chrome_css_path_label.set_text(path)
                    self.status_push(_("userChrome.css selected: %(path)s") % {"path": path})
        dialog.destroy()

    def _on_clear_chrome_css(self, btn):
        """Clears the currently selected userChrome.css path."""
        self._chrome_css_source_path = ""
        self.chrome_css_path_label.set_text(_("No file selected"))
        self.status_push(_("userChrome.css selection cleared"))

    def on_browser_changed(self, combo, _):
        idx = combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        
        available_keys = list(CONFIG.get("available_browsers", {}).keys())
        if idx < len(available_keys):
            browser_key = available_keys[idx]
            chromium_based = browser_key in ["edge", "brave", "vivaldi", "chrome", "chromium", "opera", "ungoogled-chromium"]
            self.gamepad_check.set_sensitive(chromium_based)
            if not chromium_based:
                self.gamepad_check.set_active(False)
            self._update_firefox_advanced_visibility(browser_key)

    def populate_extensions(self, app):
        while True:
            row = self.ext_listbox.get_row_at_index(0)
            if row:
                self.ext_listbox.remove(row)
            else:
                break

        if not app:
            return

        installed_exts = load_installed_extensions(app)
        
        if not installed_exts:
            row = Gtk.ListBoxRow()
            lbl = Gtk.Label(label="No extensions installed")
            lbl.set_halign(Gtk.Align.START)
            lbl.set_margin_top(6)
            lbl.set_margin_bottom(6)
            lbl.set_margin_start(12)
            lbl.set_margin_end(12)
            row.set_child(lbl)
            self.ext_listbox.append(row)
        else:
            for ext in installed_exts:
                row = Gtk.ListBoxRow()
                box = Gtk.Box(spacing=12)
                box.set_margin_top(6)
                box.set_margin_bottom(6)
                box.set_margin_start(12)
                box.set_margin_end(12)
                lbl = Gtk.Label(label=ext.get("name", "Unknown"))
                lbl.set_halign(Gtk.Align.START)
                lbl.set_hexpand(True)
                box.append(lbl)
                btn = Gtk.Button(label="Remove")
                btn.add_css_class("destructive-action")
                btn.connect("clicked", lambda b, e=ext: self.on_remove_ext(app, e))
                box.append(btn)
                row.set_child(box)
                self.ext_listbox.append(row)

    def update_button_states(self):
        idx = self.app_combo.get_selected()
        valid = idx != Gtk.INVALID_LIST_POSITION and idx < len(self.sorted_apps_list)

        self.install_btn.set_sensitive(valid)
        self.uninstall_btn.set_sensitive(valid)
        self.clone_btn.set_sensitive(valid)
        self.remove_btn.set_sensitive(valid)
        self.backup_btn.set_sensitive(valid)
        self.install_preset_btn.set_sensitive(valid)
        self.open_store_btn.set_sensitive(valid)
        self.add_custom_ext_btn.set_sensitive(valid)

        if valid:
            app = self.sorted_apps_list[idx]
            slug = slugify(app["name"])
            installed: bool = slug in set(list_installed_apps())
            self.install_btn.set_sensitive(not installed)
            self.uninstall_btn.set_sensitive(installed)
            self.backup_btn.set_sensitive(installed)

    def on_install_presets(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        available = get_available_presets(app)
        
        if not available:
            dialog = Adw.MessageDialog(
                transient_for=self,
                heading="No Presets Available",
                body=f"All available presets for {app['name']} are already installed."
            )
            dialog.add_response("ok", "OK")
            dialog.show()
            return
        
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading=f"Install Extension Presets for {app['name']}?",
            body=f"This will open your browser to install {len(available)} extension(s)."
        )
        dialog.add_response("cancel", "Cancel")
        dialog.add_response("install", "Install")
        dialog.set_response_appearance("install", Adw.ResponseAppearance.SUGGESTED)
        dialog.show()

        def on_response(dlg, resp):
            if resp == "install":
                profile_cfg = load_profile_config(app)
                browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()
                preset_key = get_app_key(app)
                profile_dir = get_profile_dir(app)
                launched = launch_extension_manager(browser_key, preset_key, profile_dir)
                if launched:
                    installed_exts = load_installed_extensions(app)
                    installed_exts.extend(available)
                    save_installed_extensions(app, installed_exts)
                    self.populate_extensions(app)
                    self.status_push(_("Launched browser for extension installation"))
                else:
                    self.status_push(_("Failed to launch browser for extensions — check logs"))
            dlg.close()
            
        dialog.connect("response", on_response)

    def on_open_store(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        profile_cfg = load_profile_config(app)
        browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()
        browser_cfg = get_browsers().get(browser_key, {})
        store_url = browser_cfg.get("store_url", "https://chromewebstore.google.com/")
        if not validate_url(store_url):
            self.status_push(_("Invalid store URL"))
            return
        profile_dir = get_profile_dir(app)
        _open_url_in_pwa_browser(browser_key, profile_dir, store_url)
        self.status_push(_("Opened extension store in PWA browser"))

    def on_add_custom_ext(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        
        dialog = Adw.MessageDialog(transient_for=self, heading="Add Custom Extension")
        dialog.add_response("cancel", "Cancel")
        dialog.add_response("add", "Add")
        dialog.set_response_appearance("add", Adw.ResponseAppearance.SUGGESTED)
        
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8, margin_top=8, margin_bottom=8, margin_start=8, margin_end=8)
        box.append(Gtk.Label(label="Extension Name", halign=Gtk.Align.START))
        name_entry = Gtk.Entry()
        box.append(name_entry)
        box.append(Gtk.Label(label="Extension URL", halign=Gtk.Align.START))
        url_entry = Gtk.Entry()
        box.append(url_entry)
        dialog.set_extra_child(box)
        dialog.show()

        def on_response(dlg, resp):
            if resp == "add":
                name = name_entry.get_text().strip()
                url = url_entry.get_text().strip()
                if name and url:
                    # Validate URL before saving — reject non-http/https and
                    # URLs not on the same allowlist used by launch_extension_manager.
                    _ALLOWED_EXT_HOSTS = {
                        "chromewebstore.google.com",
                        "microsoftedge.microsoft.com",
                        "addons.mozilla.org",
                        "addons.opera.com",
                        "workspace.google.com",
                    }
                    def _is_safe_ext_url(u: str) -> bool:
                        if not validate_url(u):
                            return False
                        host = urlparse(u).netloc.lower().lstrip("www.")
                        return any(host == h or host.endswith("." + h) for h in _ALLOWED_EXT_HOSTS)

                    if not _is_safe_ext_url(url):
                        err_dialog = Adw.MessageDialog(
                            transient_for=self,
                            heading=_("Invalid Extension URL"),
                            body=_(
                                "Extension URLs must use https:// and come from a "
                                "recognised extension store (Chrome Web Store, Firefox "
                                "Add-ons, Edge Add-ons, Opera Add-ons, or Google "
                                "Workspace Marketplace)."
                            ),
                        )
                        err_dialog.add_response("ok", _("OK"))
                        err_dialog.show()
                        err_dialog.connect("response", lambda d, _r: d.close())
                        dlg.close()
                        return
                    installed_exts = load_installed_extensions(app)
                    installed_exts.append({"name": name, "web_url": url})
                    save_installed_extensions(app, installed_exts)
                    self.populate_extensions(app)
                    # Open the extension URL inside the PWA's browser profile so
                    # the extension is actually installed into the correct instance.
                    profile_cfg = load_profile_config(app)
                    browser_key = (profile_cfg.get("browser") or app.get("browser") or CONFIG.get("browser", "firefox")).lower()
                    profile_dir = get_profile_dir(app)
                    _open_url_in_pwa_browser(browser_key, profile_dir, url)
                    self.status_push(f"Added custom extension: {name}")
            dlg.close()
            
        dialog.connect("response", on_response)

    def on_backup_profile(self, btn):
        """Quick-backup the currently selected app's profile."""
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        backup_profile(app, self.status_push)

    def on_open_backup_manager(self, action=None, param=None):
        """Opens the Backup Manager dialog for the currently selected app."""
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION or idx >= len(self.sorted_apps_list):
            # No app selected — show a picker instead
            dialog = Adw.MessageDialog(
                transient_for=self,
                heading=_("Backup Manager"),
                body=_("Select an app in the main window first, then click Backup Manager.")
            )
            dialog.add_response("ok", _("OK"))
            dialog.show()
            dialog.connect("response", lambda d, r: d.close())
            return
        app = self.sorted_apps_list[idx]
        self._show_backup_manager_for_app(app)

    def _show_backup_manager_for_app(self, app):
        """Shows the Backup Manager window for a specific app."""
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading=_("Backup Manager — %(name)s") % {"name": app["name"]},
            body=_("Manage backups stored in ~/.pwa_manager/.backup/%(slug)s/") % {"slug": slugify(app["name"])},
        )
        dialog.set_default_size(560, 420)

        outer = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8,
                        margin_top=8, margin_bottom=8,
                        margin_start=8, margin_end=8)

        # ── Backup-now button ──
        backup_now_btn = Gtk.Button(label=_("⬇  Create Backup Now"))
        backup_now_btn.add_css_class("suggested-action")
        outer.append(backup_now_btn)

        # ── Backup list ──
        list_label = Gtk.Label(label=_("<b>Existing Backups</b>"), use_markup=True,
                               halign=Gtk.Align.START)
        outer.append(list_label)

        scroll = Gtk.ScrolledWindow()
        scroll.set_min_content_height(200)
        scroll.set_vexpand(True)
        listbox = Gtk.ListBox()
        listbox.set_selection_mode(Gtk.SelectionMode.SINGLE)
        scroll.set_child(listbox)
        outer.append(scroll)

        # ── Restore / Delete buttons ──
        action_box = Gtk.Box(spacing=8)
        restore_btn = Gtk.Button(label=_("↩  Restore Selected"))
        delete_btn  = Gtk.Button(label=_("🗑  Delete Selected"))
        delete_btn.add_css_class("destructive-action")
        action_box.append(restore_btn)
        action_box.append(delete_btn)
        outer.append(action_box)

        dialog.set_extra_child(outer)
        dialog.add_response("close", _("Close"))
        dialog.show()

        def _populate():
            # Clear
            while True:
                row = listbox.get_row_at_index(0)
                if row:
                    listbox.remove(row)
                else:
                    break
            backups = list_backups(app)
            if not backups:
                row = Gtk.ListBoxRow()
                lbl = Gtk.Label(label=_("No backups yet."),
                                halign=Gtk.Align.START,
                                margin_top=6, margin_bottom=6,
                                margin_start=12, margin_end=12)
                row.set_child(lbl)
                listbox.append(row)
                restore_btn.set_sensitive(False)
                delete_btn.set_sensitive(False)
            else:
                restore_btn.set_sensitive(True)
                delete_btn.set_sensitive(True)
                for b in backups:
                    row = Gtk.ListBoxRow()
                    row._backup_info = b
                    inner = Gtk.Box(spacing=8,
                                    margin_top=6, margin_bottom=6,
                                    margin_start=12, margin_end=12)
                    ts_str = datetime.datetime.fromtimestamp(b["mtime"]).strftime("%Y-%m-%d %H:%M")
                    lbl = Gtk.Label(
                        label=f"{ts_str}  •  {b['size_mb']} MB  •  {b['name']}",
                        halign=Gtk.Align.START,
                        xalign=0,
                    )
                    lbl.set_hexpand(True)
                    inner.append(lbl)
                    row.set_child(inner)
                    listbox.append(row)

        _populate()

        def _on_backup_now(_btn):
            result = backup_profile(app)
            if result:
                _populate()
                self.status_push(f"Backup saved: {result.name}")
            else:
                self.status_push("Backup failed — check logs")

        def _on_restore(_btn):
            row = listbox.get_selected_row()
            if not row or not hasattr(row, "_backup_info"):
                return
            b = row._backup_info
            confirm = Adw.MessageDialog(
                transient_for=self,
                heading=_("Restore Profile?"),
                body=_(
                    "This will overwrite the current profile for %(name)s\n"
                    "with the backup from %(ts)s.\n\n"
                    "This cannot be undone (consider creating a backup first)."
                ) % {"name": app["name"], "ts": b["name"]},
            )
            confirm.add_response("cancel", _("Cancel"))
            confirm.add_response("restore", _("Restore"))
            confirm.set_response_appearance("restore", Adw.ResponseAppearance.SUGGESTED)
            confirm.show()

            def _do_restore(d, resp):
                if resp == "restore":
                    restore_profile(b["path"], app, self.status_push)
                    _populate()
                d.close()

            confirm.connect("response", _do_restore)

        def _on_delete(_btn):
            row = listbox.get_selected_row()
            if not row or not hasattr(row, "_backup_info"):
                return
            b = row._backup_info
            confirm = Adw.MessageDialog(
                transient_for=self,
                heading=_("Delete Backup?"),
                body=_("Permanently delete %(name)s?") % {"name": b["name"]},
            )
            confirm.add_response("cancel", _("Cancel"))
            confirm.add_response("delete", _("Delete"))
            confirm.set_response_appearance("delete", Adw.ResponseAppearance.DESTRUCTIVE)
            confirm.show()

            def _do_delete(d, resp):
                if resp == "delete":
                    delete_backup(b["path"], self.status_push)
                    _populate()
                d.close()

            confirm.connect("response", _do_delete)

        backup_now_btn.connect("clicked", _on_backup_now)
        restore_btn.connect("clicked", _on_restore)
        delete_btn.connect("clicked", _on_delete)
        dialog.connect("response", lambda d, r: d.close())

    def on_clone(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        
        dialog = Adw.MessageDialog(transient_for=self, heading=f"Clone {app['name']}")
        dialog.add_response("cancel", "Cancel")
        dialog.add_response("clone", "Clone")
        dialog.set_response_appearance("clone", Adw.ResponseAppearance.SUGGESTED)
        
        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8, margin_top=8, margin_bottom=8, margin_start=8, margin_end=8)
        box.append(Gtk.Label(label="New App Name", halign=Gtk.Align.START))
        name_entry = Gtk.Entry()
        name_entry.set_text(f"{app['name']} (Clone)")
        box.append(name_entry)
        dialog.set_extra_child(box)
        dialog.show()

        def on_response(dlg, resp):
            if resp == "clone":
                new_name = name_entry.get_text().strip()
                if new_name:
                    new_slug = slugify(new_name)
                    if new_slug in CONFIG["apps"]:
                        err = Adw.MessageDialog(
                            transient_for=self,
                            heading=_("Name Already Exists"),
                            body=_(
                                "An app named %(name)r already exists (or maps to the "
                                "same identifier). Please choose a different name."
                            ) % {"name": new_name},
                        )
                        err.add_response("ok", _("OK"))
                        err.show()
                        err.connect("response", lambda d, _r: d.close())
                        dlg.close()
                        return
                    new_app = app.copy()
                    new_app["name"] = new_name
                    CONFIG["apps"][new_slug] = new_app
                    save_config()
                    self.populate_app_combo()
                    new_index = next((i for i, a in enumerate(self.sorted_apps_list) if a["name"] == new_name), 0)
                    self.app_combo.set_selected(new_index)
                    self.status_push(f"Cloned to {new_name}")
            dlg.close()
            
        dialog.connect("response", on_response)

    def on_install(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return
        app = self.sorted_apps_list[idx]
        self._perform_install(app)

    def on_install_custom(self, btn):
        # Self-contained dialog that asks for both URL and name.
        # The browser selection is pre-filled from the main window's browser combo
        # so the user's current choice carries over without extra clicks.
        # We do NOT read self.url_entry here — that field belongs to the
        # app-selection panel and may contain an existing app's URL, which
        # was the original cause of this being broken.
        dialog = Adw.MessageDialog(transient_for=self, heading=_("Install Custom PWA"))
        dialog.add_response("cancel", _("Cancel"))
        dialog.add_response("install", _("Install"))
        dialog.set_response_appearance("install", Adw.ResponseAppearance.SUGGESTED)
        dialog.set_response_enabled("install", False)

        box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10,
                      margin_top=8, margin_bottom=8, margin_start=8, margin_end=8)

        box.append(Gtk.Label(label=_("URL (https://…)"), halign=Gtk.Align.START))
        url_input = Gtk.Entry()
        url_input.set_placeholder_text("https://example.com")
        url_input.set_hexpand(True)
        box.append(url_input)

        box.append(Gtk.Label(label=_("App Name"), halign=Gtk.Align.START))
        name_input = Gtk.Entry()
        name_input.set_placeholder_text(_("My App"))
        name_input.set_hexpand(True)
        box.append(name_input)

        dialog.set_extra_child(box)
        dialog.show()

        def _update_install_btn(*_):
            url_ok  = validate_url(url_input.get_text().strip())
            name_ok = bool(name_input.get_text().strip())
            dialog.set_response_enabled("install", url_ok and name_ok)

        def _infer_name(*_):
            """Auto-fill the name field from the URL while it is still empty."""
            raw = url_input.get_text().strip()
            if validate_url(raw) and not name_input.get_text().strip():
                try:
                    inferred = urlparse(raw).netloc.replace("www.", "").split(".")[0].capitalize()
                    if inferred:
                        name_input.set_text(inferred)
                except Exception:
                    pass
            _update_install_btn()

        url_input.connect("changed", _infer_name)
        name_input.connect("changed", _update_install_btn)

        def on_response(dlg, resp):
            if resp == "install":
                url  = url_input.get_text().strip()
                name = name_input.get_text().strip()
                if url and name and validate_url(url):
                    available_keys = list(CONFIG.get("available_browsers", {}).keys())
                    selected_idx = self.browser_combo.get_selected()
                    browser_key_selected = (
                        available_keys[selected_idx]
                        if selected_idx < len(available_keys)
                        else CONFIG.get("browser", "firefox")
                    )
                    app = {
                        "name": name,
                        "url": url,
                        "kiosk": self.kiosk_check.get_active(),
                        "gamepad": self.gamepad_check.get_active() if self.gamepad_check.get_sensitive() else False,
                        "browser": browser_key_selected,
                    }
                    app_slug = slugify(name)
                    CONFIG["apps"][app_slug] = app
                    save_config()
                    self.populate_app_combo()
                    new_index = next(
                        (i for i, a in enumerate(self.sorted_apps_list) if a["name"] == name), 0
                    )
                    self.app_combo.set_selected(new_index)
                    self._perform_install(app)
            dlg.close()

        dialog.connect("response", on_response)

    def _perform_install(self, app):
        kiosk = self.kiosk_check.get_active()
        gamepad = self.gamepad_check.get_active() if self.gamepad_check.get_sensitive() else False
        
        available_keys = list(CONFIG.get("available_browsers", {}).keys())
        selected_idx = self.browser_combo.get_selected()
        browser_key = available_keys[selected_idx] if selected_idx < len(available_keys) else CONFIG.get("browser", "firefox")

        gpu = self.gpu_check.get_active()
        CONFIG["gpu"] = gpu
        CONFIG["kiosk"] = kiosk
        CONFIG["nice"] = int(self.nice_spin.get_value())
        CONFIG["ionice"] = int(self.ionice_spin.get_value())

        # Work on a shallow copy so we don't mutate the live CONFIG["apps"] entry
        # (and by extension DEFAULT_APPS objects) before save_config() completes.
        app = app.copy()
        app["kiosk"] = kiosk
        app["gamepad"] = gamepad
        app["browser"] = browser_key
        # Persist the updated copy back into CONFIG so save_config() sees it.
        app_slug = slugify(app["name"])
        CONFIG["apps"][app_slug] = app
        save_config()
        profile_cfg = load_profile_config(app)
        profile_cfg["browser"] = browser_key
        profile_cfg["gamepad"] = gamepad
        # Store per-app nice/ionice so the wrapper can be regenerated with the
        # same values even if the global defaults change later.
        profile_cfg["nice"]   = int(self.nice_spin.get_value())
        profile_cfg["ionice"] = int(self.ionice_spin.get_value())
        # Persist the userChrome.css source path (Firefox only) so it can be
        # re-applied on reinstall and shown correctly when the app is re-selected.
        if browser_key.lower() == "firefox" and self._chrome_css_source_path:
            profile_cfg["userchrome_css_source"] = self._chrome_css_source_path
        elif browser_key.lower() != "firefox":
            profile_cfg.pop("userchrome_css_source", None)
        save_profile_config(app, profile_cfg)
        
        install_app(app, browser_key, kiosk, int(self.nice_spin.get_value()), int(self.ionice_spin.get_value()), gpu, self.status_push)

        self.populate_app_combo()
        # Re-select the same app so the ✓ marker and button states are in sync.
        target_name = app.get("name", "")
        new_idx = next(
            (i for i, a in enumerate(self.sorted_apps_list) if a.get("name") == target_name),
            0,
        )
        self.app_combo.set_selected(new_idx)
        self.update_button_states()

    def on_uninstall(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION:
            return

        app = self.sorted_apps_list[idx]
        uninstall_app(app["name"])
        self.status_push(f"Uninstalled {app['name']}")
        self.populate_app_combo()
        # Keep the selection near where it was: clamp to the new list length.
        if self.sorted_apps_list:
            new_idx = min(idx, len(self.sorted_apps_list) - 1)
            self.app_combo.set_selected(new_idx)
            self.populate_app_fields(self.sorted_apps_list[new_idx])
        self.update_button_states()

    def on_refresh(self, btn):
        current_search = self.search_entry.get_text().strip()
        self.populate_app_combo(current_search)
        self.update_button_states()
        self.status_push(_("Refreshed"))

    def on_remove_app(self, btn):
        idx = self.app_combo.get_selected()
        if idx == Gtk.INVALID_LIST_POSITION or idx >= len(self.sorted_apps_list):
            return
        
        app = self.sorted_apps_list[idx] 
        app_name = app["name"]
        app_slug = slugify(app_name)
        
        dialog = Adw.MessageDialog(
            transient_for=self,
            heading=_("Remove %(name)s?") % {"name": app_name},
            body=_("Remove entry. Optionally delete profile.")
        )
        dialog.add_response("cancel", _("Cancel"))
        dialog.add_response("keep", _("Keep Profile"))
        dialog.add_response("delete", _("Delete Profile"))
        dialog.set_response_appearance("delete", Adw.ResponseAppearance.DESTRUCTIVE)
        dialog.show()

        def on_response(dlg, resp):
            if resp == "cancel":
                dlg.close()
                return
            
            removed = CONFIG["apps"].pop(app_slug, None) 
            
            if removed:
                remove_app_files(removed)
            
            if resp == "delete":
                pd = get_profile_dir(app)
                try:
                    shutil.rmtree(pd)
                    self.status_push(_("Removed + profile deleted"))
                except Exception as e:
                    self.status_push(_("Profile delete failed: %(error)s") % {"error": e})
            else:
                self.status_push(_("Removed (profile kept)"))
            
            save_config()
            current_search = self.search_entry.get_text().strip()
            self.populate_app_combo(current_search)
            self.update_button_states()
            dlg.close()
        dialog.connect("response", on_response)

    def on_remove_ext(self, app, ext):
        exts = load_installed_extensions(app)
        if ext in exts:
            exts.remove(ext)
            save_installed_extensions(app, exts)
        self.populate_extensions(app)

# ---------------- Main ----------------
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--launch-app", type=str)
    args = parser.parse_args()
    if args.launch_app:
        launch_app_from_cli(args.launch_app)
        return
    Adw.init()
    app = PWAManagerApp()
    app.run(sys.argv)

if __name__ == "__main__":
    script_path = Path(__file__)
    if not os.access(script_path, os.X_OK):
        try:
            script_path.chmod(0o755)
        except OSError:
            pass
    main()
