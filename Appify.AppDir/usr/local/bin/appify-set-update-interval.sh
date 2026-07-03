#!/bin/bash
set -euo pipefail

# =====================================
# Change how often appify-updater.timer checks for updates.
# Uses the same pkexec-safe write pattern as the rest of the Griffin tools:
# build the full unit file in /tmp first, then let a single privileged `cp`
# move it into place atomically.
# =====================================

TIMER_UNIT="/etc/systemd/system/appify-updater.timer"

usage() {
    cat <<EOF
Usage: $(basename "$0") <schedule>

Set how often Appify checks for updates.

Examples:
  $(basename "$0") daily              # once a day at 04:00 (default)
  $(basename "$0") hourly             # once every hour
  $(basename "$0") weekly             # once a week
  $(basename "$0") 02:30              # daily at a specific time (HH:MM)
  $(basename "$0") "*-*-* 04:00:00"   # any custom systemd OnCalendar expression
EOF
    exit 1
}

[ $# -eq 1 ] || usage
INPUT="$1"

case "$INPUT" in
    hourly)
        ONCALENDAR="hourly"
        ;;
    daily)
        ONCALENDAR="*-*-* 04:00:00"
        ;;
    weekly)
        ONCALENDAR="weekly"
        ;;
    [0-9][0-9]:[0-9][0-9])
        ONCALENDAR="*-*-* ${INPUT}:00"
        ;;
    *)
        ONCALENDAR="$INPUT"
        ;;
esac

# Validate the calendar expression before touching anything on disk
if command -v systemd-analyze &>/dev/null; then
    if ! systemd-analyze calendar "$ONCALENDAR" &>/dev/null; then
        echo "Error: '$ONCALENDAR' is not a valid schedule/OnCalendar expression." >&2
        exit 1
    fi
fi

TMP_FILE=$(mktemp /tmp/appify-updater-timer.XXXXXX)
cat > "$TMP_FILE" <<EOF
[Unit]
Description=Run Appify Updater ($ONCALENDAR)

[Timer]
OnCalendar=$ONCALENDAR
Persistent=true

[Install]
WantedBy=timers.target
EOF
chmod 644 "$TMP_FILE"

pkexec cp "$TMP_FILE" "$TIMER_UNIT"
rm -f "$TMP_FILE"

pkexec systemctl daemon-reload
pkexec systemctl restart appify-updater.timer

echo "✅ Appify update check schedule set to: $ONCALENDAR"
systemctl list-timers appify-updater.timer --no-pager 2>/dev/null || true
