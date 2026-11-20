# Appify on macOS

`appify` is one cross-platform source file. On macOS it does the same job as on
Linux and Windows (turn a website into its own app window with an isolated browser
profile), using native macOS mechanisms.

## What the macOS build does differently

| Linux | macOS |
|---|---|
| bash wrapper + `.desktop` file | a tiny launcher **`.app` bundle per web app** in `~/Applications/Appify Apps/` (Spotlight / Finder / Launchpad), with its own icon |
| `which` / Flatpak / Snap detection | looks for the browser `.app` in `/Applications` and `~/Applications` |
| default browser via `xdg-settings` | default browser via LaunchServices; **Safari can't run web apps in app mode**, so if Safari is your default Appify picks the first installed supported browser |
| `~/.appify` | `~/Library/Application Support/Appify` |
| `nice` + `ionice` | `nice` works for positive values (lower priority); negative values need root and are ignored. I/O priority is hidden |
| Wayland/X11 options, WebHID portal | not applicable (hidden / built in) |
| systemd timer self-updater | checks at every start and shows a notice when a newer paid build is available |

Supported browsers: Chrome, Edge, Firefox, Brave, Vivaldi, Opera, Chromium, Ungoogled Chromium.

## Install (users)

1. Download the latest `Appify-<version>-macos-arm64.dmg` (Apple Silicon: M1 or newer) or `...-x86_64.dmg` (Intel) from Ko-fi **Payments & Orders**.
2. Open it and drag **Appify** onto **Applications**.
3. First launch: the app is not notarized, so macOS will refuse a normal double-click.
   **Right-click Appify → Open → Open** (once). On newer macOS, if there is no Open button:
   System Settings → Privacy & Security → *Open Anyway*. Terminal alternative:
   `xattr -dr com.apple.quarantine /Applications/Appify.app`

## Getting the DMGs built by GitHub Actions

`.github/workflows/build-macos.yml` builds on two runners, one per architecture
(`macos-15` = Apple Silicon, `macos-15-intel` = Intel), runs a smoke test against the packaged
app, and produces:

* `Appify-<version>-macos-arm64.dmg`
* `Appify-<version>-macos-x86_64.dmg`
* `SHA256SUMS-macos-<arch>.txt`

The workflow runs for pull requests and can also be started manually (Actions → *Build macOS* →
*Run workflow*). Download the two architecture-specific artifacts from the completed run and upload
them to Ko-fi. The workflow does not publish binaries to GitHub Releases.

Keep `CURRENT_VERSION` in `appify` aligned with the paid build you upload. After uploading it,
update `windows-update.json`'s `version` value so existing Windows and macOS buyers are notified.
Updates are free for previous purchasers and available from Ko-fi **Payments & Orders**.

> GitHub is retiring `macos-14`; this workflow uses `macos-15` / `macos-15-intel`. If GitHub retires the
> Intel runner label, delete the `x86_64` matrix entry (Apple Silicon Macs are the large majority).

## Building locally (optional)

```bash
./macos/build.sh        # needs Python 3.10+ ; makes release/Appify-<version>-macos-<your arch>.dmg
```
Run from source for development: `pip install -r requirements.txt && python3 appify`.

## Things to know

* **Not notarized.** To remove the first-launch warning you need an Apple Developer account ($99/yr): sign with a
  *Developer ID Application* certificate and notarize with `notarytool`.
* **Dock icon:** the launcher `.app` has no Dock icon of its own; when an app runs, the Dock shows the browser's icon
  (the launcher's custom icon is what you see in Finder, Spotlight and Launchpad). Pinning the running window to the Dock
  pins the browser. This is a limit of launching a browser from a script-based `.app`.
* **Moving/removing apps:** each web app lives in `~/Applications/Appify Apps/<Name>.app`. Use Appify's **Uninstall**
  button per app; deleting Appify itself does not remove them or their profiles in `~/Library/Application Support/Appify`.
* **Export/Import** works between Linux, Windows and macOS for the app list and settings; browser profiles
  are OS/browser specific, so extensions and logins need to be redone.
* **Permissions:** macOS may ask the *browser* (not Appify) for camera/mic/notification access per profile, as usual.
