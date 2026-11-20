# Appify on Windows

`appify` is now one cross-platform source file. On Windows 10/11 it does the same
job as on Linux (turn a website into its own app window with an isolated browser
profile), using native Windows mechanisms instead of Linux ones.

## What the Windows build does differently

| Linux | Windows |
|---|---|
| bash wrapper + `.desktop` file | **Start Menu shortcut** (`Start Menu\Programs\Appify Apps\<App>.lnk`) pointing straight at the browser with `--user-data-dir` / `--app` |
| `which` / Flatpak / Snap detection | well-known install paths + the `App Paths` registry key |
| default browser via `xdg-settings` | default browser via the `UserChoice` registry key (falls back to Edge, which ships with Windows) |
| `~/.appify` | `%LOCALAPPDATA%\Appify` |
| `nice` + `ionice` | `nice` maps to a Windows priority class (applies when launched from Appify's **Launch** button / `--launch-app`; Start Menu shortcuts run at normal priority). I/O priority is hidden. |
| Wayland/X11 options, WebHID portal | not applicable (hidden / built in) |
| systemd timer self-updater (.deb / AppImage) | checks for updates at every start; **Download & Install Update** runs the Setup.exe silently, then Appify restarts |

Supported browsers: Edge, Chrome, Firefox, Brave, Vivaldi, Opera, Chromium, Ungoogled Chromium.

## Getting the Windows files built by GitHub Actions

`.github/workflows/build-windows.yml` runs on a `windows-latest` runner and produces:

* `Appify-Setup-<version>.exe` — installer (per-user by default, no admin prompt)
* `Appify-<version>-windows-portable.zip` — unzip and run
* `SHA256SUMS-windows.txt`

The build bundles `store.json`, so the app catalog is available immediately and
offline; Appify refreshes it from GitHub in the background when a connection is available.

Run the workflow manually (Actions tab → *Build Windows* → *Run workflow*). Its
outputs are workflow artifacts only and are never attached to GitHub Releases;
upload the installer to Ko-fi for purchasers to access.

Windows checks `windows-update.json` for the latest Ko-fi version. After uploading
a new installer to Ko-fi, update that file's `version` value. The app notifies
users and directs them to sign in to Ko-fi and open **Payments & Orders**; it
does not download or install paid files automatically.

The app version comes from `CURRENT_VERSION` in `appify`; keep the installer
version and update manifest aligned with the file currently available to buyers.

## Building locally (optional)

```powershell
# Python 3.10+ and (for the installer) Inno Setup 6:  winget install JRSoftware.InnoSetup
.\windows\build.ps1                 # exe + portable zip + installer  -> .\release
.\windows\build.ps1 -SkipInstaller  # no Inno Setup needed
```

Run from source for development: `pip install -r requirements.txt` then `python appify`.

## Repo layout

```
appify                         # the app (Linux + Windows)  <- replaces your current file
requirements.txt               # PyQt6, packaging
windows/appify.ico             # exe / installer icon
windows/appify.png             # bundled window icon
windows/appify.iss             # Inno Setup installer script
windows/build.ps1              # local build helper
.github/workflows/build-windows.yml
```
The Linux files (`AppRun`, `.desktop`, `appify-updater.*`, `appify-set-update-interval.sh`) are untouched.

## Notes

* The exe is **unsigned**, so Windows SmartScreen may show "unknown publisher" (More info → Run anyway) and some
  antivirus products are suspicious of PyInstaller builds. Code signing (e.g. SignPath for open source) fixes that.
* Uninstalling Appify leaves your apps' profiles in `%LOCALAPPDATA%\Appify` and the Start Menu shortcuts in
  `Appify Apps`. Use Appify's **Uninstall** button for each app first if you want them gone.
* Export/Import works between Linux and Windows for the app list and settings; browser profiles are
  browser/OS specific, so extensions and logins need to be redone on the other OS.
* macOS is not supported by this change.
