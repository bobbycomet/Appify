#!/bin/bash
# Double-click to run Appify from source on a Mac (no build needed).
# First run creates a private Python environment next to this file (~1 minute).
cd "$(dirname "$0")" || exit 1
if ! command -v python3 >/dev/null 2>&1; then
  echo "Python 3 is required. macOS will offer to install the Command Line Tools; accept, then run this again."
  python3 --version 2>/dev/null; read -n 1 -s -r -p "Press any key to close"; exit 1
fi
if [ ! -d .venv ]; then
  echo "Setting up (first run only)..."
  python3 -m venv .venv && .venv/bin/pip install --quiet --upgrade pip && .venv/bin/pip install --quiet -r requirements.txt \
    || { echo "Setup failed."; read -n 1 -s -r -p "Press any key to close"; exit 1; }
fi
exec .venv/bin/python appify
