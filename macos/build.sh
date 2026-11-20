#!/usr/bin/env bash
# Local macOS build (same steps as .github/workflows/build-macos.yml).
# Run from anywhere:   ./macos/build.sh
# Produces release/Appify-<version>-macos-<arch>.dmg for the Mac you run it on.
set -euo pipefail
cd "$(dirname "$0")/.."

VERSION=$(sed -n 's/^CURRENT_VERSION *= *"\([^"]*\)".*/\1/p' appify | head -n1)
[ -n "$VERSION" ] || { echo "Could not read CURRENT_VERSION from ./appify"; exit 1; }
case "$(uname -m)" in
  arm64)  ARCH=arm64 ;;
  x86_64) ARCH=x86_64 ;;
  *)      ARCH=$(uname -m) ;;
esac
echo "Building Appify $VERSION for macOS ($ARCH)..."

python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt "pyinstaller>=6.10,<7"

rm -rf build dist release build_src dmg_src
mkdir -p build_src release
cp appify build_src/appify_main.py          # PyInstaller wants a .py file name

python3 -m PyInstaller --noconfirm --clean --windowed --name Appify \
  --icon "$PWD/macos/appify.icns" \
  --osx-bundle-identifier com.bobbycomet.appify \
  --add-data "$PWD/macos/appify.png:." \
  --add-data "$PWD/store.json:." \
  --exclude-module tkinter \
  build_src/appify_main.py

PLIST=dist/Appify.app/Contents/Info.plist
for key in CFBundleShortVersionString CFBundleVersion; do
  /usr/libexec/PlistBuddy -c "Set :$key $VERSION" "$PLIST" 2>/dev/null \
    || /usr/libexec/PlistBuddy -c "Add :$key string $VERSION" "$PLIST"
done
# Ad-hoc signature (required for arm64 binaries to run; NOT a Developer ID signature).
codesign --force --deep --sign - dist/Appify.app
codesign --verify --deep --strict dist/Appify.app

# Smoke test: builds the whole UI inside the packaged app, then exits.
rm -f selftest.txt
dist/Appify.app/Contents/MacOS/Appify --selftest "$PWD/selftest.txt"
echo "Self-test: $(cat selftest.txt)"
rm -f selftest.txt

mkdir -p dmg_src
cp -R dist/Appify.app dmg_src/
ln -s /Applications dmg_src/Applications
hdiutil create -volname "Appify $VERSION" -srcfolder dmg_src -ov -format UDZO \
  "release/Appify-$VERSION-macos-$ARCH.dmg"
rm -rf dmg_src

echo
echo "Done:"
ls -lh release
