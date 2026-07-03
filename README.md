<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

<div align="center">

# Appify

**Search the defaults or paste a link, pick your browser, and click install. That's it.**

**Every app runs in its own isolated profile with its own icon and launcher. Everything is handled automatically, but fully customizable if you want it.**

**3.0 is here: a full PyQt6 rewrite, the Griffin Dark Theme, and a much deeper set of options. See Why 3.0? below.**

**Upgrading from an older version? If you run into migration issues, check the [FAQs](https://github.com/bobbycomet/Appify/wiki/FAQs) and [Debugging](https://github.com/bobbycomet/Appify/wiki/How-to-debug) pages.**

[![Latest Release](https://img.shields.io/badge/release-v3.0.0-blue)](https://github.com/bobbycomet/Appify/releases/tag/v3.0.0)
[![Part of Griffin Linux](https://img.shields.io/badge/project-Griffin%20Linux-purple)](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/)

[Video Showcase](https://youtu.be/Ql2JzdyAA6M?si=vyLsMP9mZxMolYvI) | [Full Comparison Table](https://bobbycomet.github.io/Appify/) | [Discord](https://discord.gg/7fEt5W7DPh)

### The Old VS New Look

</div>

<img width="1920" height="1080" alt="Screenshot_20260414_022537" src="https://github.com/user-attachments/assets/3ad375f1-d641-40df-b83f-d1fd275cd8db" />

<img width="1920" height="1080" alt="Screenshot_20260703_053801" src="https://github.com/user-attachments/assets/23d0d519-ec0d-430b-9336-394a3c381050" />
<img width="1920" height="1080" alt="Screenshot_20260703_053734" src="https://github.com/user-attachments/assets/07ca8ff9-aa12-4e9b-aa77-919edcb68b3e" />
<img width="1920" height="1080" alt="Screenshot_20260703_053655" src="https://github.com/user-attachments/assets/97180002-d23a-4246-8d4b-626e52162b8f" />
<img width="1920" height="1080" alt="Screenshot_20260702_113739" src="https://github.com/user-attachments/assets/6577058f-104e-47e9-8c63-7765b9aef02f" />

Firefox userChrome.css and userContent.css example:

<img width="1920" height="1080" alt="Screenshot_20260703_053822" src="https://github.com/user-attachments/assets/5e297340-169f-4eb3-9d11-eed70fe2ffe1" />


---

## Why 3.0?

Appify first launched in August 2025 on GTK4 and libadwaita. That's a great stack if you're on GNOME, but Griffin Linux runs KDE Plasma, and most of the Linux desktop isn't GNOME either; Cinnamon, XFCE, and everything else all had to fight the same libadwaita styling and packaging assumptions to look and behave right. It worked, but it was never quite *at home* anywhere except GNOME.

3.0 is a full rewrite of the interface on PyQt6. Nothing about how Appify actually works changed underneath: same isolated profile-per-app architecture, same browser detection, same install flow, but the interface is now the Griffin Dark Theme you already know from Persona, Grix, and the rest of the Griffin toolset, and it no longer needs a GNOME-shaped dependency stack to look right.

| Method | Steps Involved | Isolation | Customization | Average Time | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Appify** | Open Appify, Search or pick pre-registered app, (optional: browser + advanced options), install | **Excellent** (dedicated per-app profile) | **High** (browser choice, custom icons, CSS, priorities, kiosk, etc.) | 14.05 seconds from opening Appify to opening an app (no advanced options) | Fastest path with the most control. Pre-registered popular apps. |
| **Linux Mint Webapp Manager** | Open Webapp Manager, Paste URL, Choose browser, Install | Limited | Low | 60–90 seconds | Good basic experience, but less flexible outside Mint/Cinnamon. |
| **Browser Built-in "Install App"** *(Chrome/Edge/Brave)* | Open browser, Navigate to site, Menu, Install | Poor (shares main profile) | None | 60–90 seconds | Quick but messy for multiple apps (cookies, extensions, and data bleed). |
| **Nativefier / CLI Tools** | Install Node.js + tool, Run commands, Tweak flags | **Excellent** (but heavy) | **Very High** | 2–5+ minutes | Powerful but slow, bloated (Electron), and manual. |

While the interface was being rebuilt anyway, 3.0 also adds the things people kept asking for:

- **Pick your own app icon** instead of only the auto-downloaded favicon
- **Sort your app list** the way you actually think about it — by name, category, how recently you used it, or installed-first
- **Install or back up a whole category in one click**, instead of one app at a time
- **Appify can now update itself** — check for a new version, install it with one click, or set it to check automatically on whatever schedule you want, right from the menu

Everything that worked in 2.x still works exactly the same way. This is a rebuild of the surface, not the foundation.

## What's New in 3.0

| Feature | Before 3.0 | After 3.0 |
|---|---|---|
| **Interface** | GTK4 + libadwaita | Full PyQt6 rewrite, styled as the Griffin Dark Theme |
| **Advanced options** | Flat list of checkboxes (Kiosk, GPU, Gamepad, Nice/I-O priority, .CSS) | Tucked into a collapsible **Advanced Options** panel, with a hover tooltip explaining exactly what each one does |
| **App icons** | Auto-downloaded favicon only | Browse for your own PNG/JPEG/GIF/BMP/ICO/SVG per app, or reset back to auto |
| **Finding & ordering apps** | Search, or browse by category | Search, browse by category, *and* sort by Name, Category, Recently Used, or Installed First |
| **Installing several apps** | One at a time | **Install All in Category** installs everything in a category you don't already have |
| **Backups** | One app at a time via Backup Manager | **Backup All Installed Apps** backs up your entire library in one pass |
| **Keeping Appify updated** | Check GitHub yourself, download manually | **Update Settings** in the menu: check now, one-click download & install (works for both the `.deb` and the AppImage), or set an automatic check schedule (hourly/daily/weekly/custom) |
| **Testing an app** | Reopen it from your app launcher | **Launch** button runs any installed app directly from the manager |
| **App catalog** | Built into the app itself | Data-driven `store.json`, so new default apps can ship without waiting on an Appify release |
| **Firefox extension store** | Could falsely report "Firefox is already running" and never open | Fixed, reliably opens in the already-running window if there is one, or a fresh one if not (snaps and Flatpaks still have issues) |
| **Firefox appearance (optional)** | Not supported | Paste raw `userChrome.css` / `userContent.css` into a text field under Firefox Advanced Options to reskin the browser UI using layouts from [firefoxcss-store.github.io](https://firefoxcss-store.github.io/) — see [below](#firefox-userchromecss-and-usercontentcss-optional) |

**Known issues in 3.0:** toolbar icons and menu buttons can appear slightly smaller than intended under the Griffin Dark Theme (a cosmetic GTK4→PyQt6 rendering difference, no functional impact), and Xbox Cloud Gaming has a third-party-gamepad limitation in Chromium-based browsers that sits upstream of Appify. See the Cloud Gaming section below.

---

## Why Does Appify Exist At All?

Linux is the best desktop operating system for a lot of people. But one thing it has always lacked compared to Windows and macOS is a simple way to install web apps as real desktop apps with their own icons, taskbar entries, and isolated profiles.

The usual workarounds are messy. Chromium-based browsers have a "Create shortcut" option that technically works, but it ties your app to your main browser profile with no isolation. Firefox has nothing built in at all. Tools like GNOME Web and nativefier exist but require extra setup, have limited browser support, or rely on fragile hacks like userChrome.css that break silently every few Firefox updates.

Appify was built because none of those solutions were actually good; they work, but they cost you in other ways. Appify gives you true isolated apps, real desktop apps from any URL, using whichever browser you already have installed, with no manual config files, no terminal commands, and no breakage after browser updates.

Appify is part of the larger [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).

---

## A Note for Windows Users

If you are coming from Windows, one thing to know: Linux has two main ways to distribute apps. A `.deb` (each distro type has its own version of something similar) file is like an installer, the equivalent of an `.exe` setup wizard. An `.AppImage` is a self-contained portable file you can just run directly without installing anything, similar to a portable `.exe`. If you are on Ubuntu, Linux Mint, Pop!_OS, or any Debian-based distro, the `.deb` is the recommended choice. If your distro is not listed below or you just want something portable, the AppImage will work on almost any modern Linux system.

---

## How It Works

Appify is fully GUI-controlled. Open the app, and the entire process looks like this:

1. Search for a site by name, browse by category, or pick from the list of 90+ popular sites
2. Appify creates an isolated browser profile instantly, using zero disk space until the app is actually launched
3. Choose which browser to use. Appify automatically detects every browser you have installed, including native, Flatpak, and Snap versions
4. Optionally pick an extension preset for the site (SponsorBlock for YouTube, BetterTTV for Twitch, etc.). Appify opens that specific browser instance so you can configure extensions just like normal. You can also add your own via the Add Custom button
5. Click Install

That is it. Typical install time is under a second. No loading bars. No account creation. No permission screens.

Once an app is installed, use the **Launch** button to test it right from the manager and open the **☰ Menu** for backups, bulk operations, wrapper regeneration, and update settings.

[Watch the video showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N) | [See the full comparison table](https://bobbycomet.github.io/Appify/)

---

## Firefox userChrome.css and userContent.css (Optional)

If you have tried to turn Firefox into a PWA launcher before, you have probably run into userChrome.css. It is the traditional approach for hiding the browser chrome and reskinning Firefox's UI. The problem is that it is fragile, Firefox updates frequently change the internal structure of the UI, and userChrome.css edits that worked perfectly last month can silently break, leaving you with a weird-looking, broken window and no obvious way to fix it.

Appify doesn't need userChrome.css to work. By default, every app uses Firefox's `--kiosk` flag (for cloud gaming) or a standard window combined with isolated profile directories and a pre-configured `user.js` file that Appify writes automatically. Each app gets its own Firefox profile with startup telemetry disabled, the homepage locked to your app's URL, and all first-run UI suppressed. The profile is fully isolated from your regular Firefox, so your main browser, bookmarks, and history are never touched; none of that requires userChrome.css.

That said, as of 3.0, userChrome.css and userContent.css support is available as an **optional** Advanced Option when Firefox is the selected browser. It's simple by design:

1. Browse [firefoxcss-store.github.io](https://firefoxcss-store.github.io/) for a layout you like.
2. Copy the raw `userChrome.css` for that layout and paste it into the userChrome.css field under Firefox Advanced Options in Appify. Do the same with `userContent.css` if the layout has one.
3. Appify writes the pasted CSS into that app's Firefox profile and enables `toolkit.legacyUserProfileCustomizations.stylesheets` automatically, no manual `about:config` editing, no hunting for the profile folder.

**This only works with CSS-only layouts.** Some layouts on firefoxcss-store also ship `.js` files for behavior that CSS alone can't do; Appify only applies `userChrome.css` and `userContent.css`, so any layout that depends on `.js` files won't fully work through Appify.

Two small test files — [`userChrome.css`](https://github.com/bobbycomet/Appify/blob/main/userChrome.css) and [`userContent.css`](https://github.com/bobbycomet/Appify/blob/main/userContent.css) — are included in the repo purely so you can try the workflow end to end. They are **not** official Griffin Linux/Appify styling, just a working example for testing this feature. Because userChrome.css support depends on Firefox's own internal UI staying stable release to release, it's opt-in and provided as-is, official support for specific layouts isn't promised, and a layout that works today may need updating after a future Firefox release.

---

## Cloud Gaming and Kiosk Mode

Kiosk mode is included in Appify specifically because of cloud gaming. When you install a cloud gaming app like Xbox Cloud Gaming, GeForce NOW, or Amazon Luna through Appify with kiosk mode enabled, it launches in a true full-screen dedicated window with no browser chrome, no tab bar, and no address bar. It behaves exactly like a native game launcher.

**Firefox is the recommended browser for most cloud gaming services.** The reason is gamepad support. Firefox has native gamepad support built in that works without any special flags or workarounds. Chromium-based browsers (Chrome, Edge, Brave, etc.) require WebHID flags, which Appify handles, to be explicitly enabled, and on Linux, those flags also require the xdg-desktop-portal daemon and a matching desktop environment backend to be running before device permission dialogs can appear. If that portal stack is not set up correctly, your controller may be silently ignored with no error message.

Xbox Cloud Gaming is the one exception, while it does default to Firefox like the rest. Appify has defaults for Xbox Cloud Gaming on a Chromium-based browser with WebHID flags pre-configured. Appify handles all of this automatically, including checking whether your portal stack is ready and warning you in the UI if it is not. Third-party (non-Xbox-branded) gamepads can still have trouble under Xbox Cloud Gaming; specifically, this is a limitation of Xbox Cloud Gaming's own Chromium support, not something Appify can work around. It was also tested with Better Xcloud, and this did not resolve the issue.

For GeForce NOW, Amazon Luna, Boosteroid, and AirGPU, Appify defaults those entries to Firefox for the most reliable out-of-the-box controller experience. While they do have flags as well, Xcloud is notorious for needing more handholding to get it working.

---

## Downloading and Installing

**Latest version: 3.0.0**

**Debian/Ubuntu/Linux Mint/Pop!_OS and other Debian-based distros:**

```
wget https://github.com/bobbycomet/Appify/releases/download/v3.0.0/Appify-3.0.0.deb
sudo dpkg -i Appify-3.0.0.deb
sudo apt-get install -f
```

Or open the `.deb` file with your software manager directly. Gdebi is also a solid choice.

**All other distros (Arch, Fedora, openSUSE, NixOS, etc.) and portable use:**

```
https://github.com/bobbycomet/Appify/releases/download/v3.0.0/Appify-3.0.0-x86_64.AppImage
```

```
chmod +x Appify-3.0.0-x86_64.AppImage
./Appify-3.0.0-x86_64.AppImage
```

You can move the AppImage anywhere you like, and it will run from there. No installation required. Once running, you can also point Appify at itself: open **☰ Menu → Update Settings…** to check for future updates or set up automatic checks, and Appify will keep updating in place — the AppImage overwrites itself at whatever path you originally put it, and the `.deb` upgrades through `apt`.

---

## Supported Distros, Must Use Systemd 

Appify is tested and known to work on the following:

**Debian-based:** Ubuntu, Linux Mint, Pop!_OS, Zorin OS, elementary OS, Debian itself

**RPM-based:** Fedora, openSUSE, Nobara (use the AppImage)

**Arch-based:** Arch Linux, Manjaro, EndeavourOS (use the AppImage)

**Independent:** NixOS, Void Linux, and most other modern systemd-based distros (use the AppImage)

Appify requires Python 3.10 or later, PyQt6, and a distro running systemd. These are included when you use the `.deb` installer. For the AppImage, everything is bundled. For manual installs on other distros, the equivalent package is typically `python3-pyqt6`.

Wayland and X11 are both fully supported. Appify automatically detects your session type and configures browser launch flags accordingly, including compositor-specific flags for KDE Plasma, GNOME, Hyprland, Sway, COSMIC, and other Wayland environments.

---

## How Backups Work

Every installed app can be backed up from within Appify — one at a time from the app's **Backup Manager**, or all at once via **☰ Menu → Backup All Installed Apps**. A backup is a single `.tar.gz` archive that contains the entire browser profile directory (cookies, logins, preferences), the launcher script, the desktop file, the app icon, and a metadata sidecar. Backups are stored in `~/.appify/.backup/<app-slug>/` and are timestamped so you can keep multiple restore points.

Appify keeps up to 10 backups per app automatically. When a new backup is created and the limit is exceeded, the oldest backup is pruned. Restoring a backup wipes the current profile and replaces it, then regenerates the launcher and desktop file with your current system paths, so restores work cleanly even if you have moved things around.

> **Note:** Before creating a backup, any extensions you have added to that app's browser profile must be removed first. This is a browser limitation, not an Appify one. Browser extensions store their files inside the profile directory in a way that can produce inconsistent archive states if they are present during the backup. Remove the extensions, take the backup, then reinstall them afterward if needed. You can also move a backup to another computer, place it in the backup folder, and Appify will find it.

---

## Changelog: Previous Updates

<details>
<summary><strong>2.2.3, Config Directory Migration & Export/Import</strong></summary>

**1. Config Directory Migration (`~/.pwa_manager` → `~/.appify`)**

- The default data directory has been renamed from `~/.pwa_manager` to `~/.appify` for better naming clarity.
- Safe, user-controlled migration:
  - On first launch, a confirmation dialog appears.
  - Users can also trigger migration anytime via the hamburger menu (Migrate to .appify…).
  - The old directory is not deleted until the user confirms the migration.
- After migration, a clear notice explains that browser extensions may need repair (a browser sandbox limitation).

**2. Export / Import System**

- Export All Data: Creates a zip archive of your entire `~/.appify` folder (profiles, scripts, backups, config, etc.).
- Import All Data: Restores from a previous export.
  - Automatically backs up your current data first.
  - Regenerates all launcher wrappers for the current machine (different browsers, Wayland/X11, Flatpak/Snap, etc.).
- Export includes a warning that browser extensions cannot be transferred due to browser sandbox restrictions.

</details>

<details>
<summary><strong>2.2.2 — Categories, Profile Size, and Wrapper Regeneration</strong></summary>

| Feature | Before 2.2.2 | After 2.2.2 |
|---|---|---|
| **Finding apps** | Search by name only | Search by name **or** browse by category in a collapsible panel |
| **Profile storage info** | No indication of how much disk space a profile uses | Profile size shown directly below the app dropdown, updated when you switch apps |
| **After switching X11 ↔ Wayland** | Had to reinstall each app individually to fix launcher flags | New "Regenerate All Wrappers" menu action rewrites every installed app's launcher at once |
| App categories | Comments only, not surfaced in the UI | All 90+ built-in apps tagged across 11 categories; custom-added apps preserved as-is |
| Wrapper scripts | Embedded session type at install time, stale after session change | Same behavior at install; now trivially refreshable for all apps in one action |

A collapsible "Browse by Category" panel sits below the app search. Open it, pick a category from the dropdown, and you see every app in that group with a ✓ next to the ones already installed. The 11 categories are: AI & Search, Productivity, Communication, Social, Streaming, Cloud Gaming, Art & Design, Streaming Tools, Utilities, Shopping, and News & Knowledge.

</details>

---

## Technical Details

Appify stores its configuration and all app profiles in `~/.appify/` (older installs used `~/.pwa_manager/`; Appify offers a one-time guided migration to `~/.appify/`). The structure looks like this:

```
~/.appify/
  config.json              # global settings and app registry (CONFIG["apps"])
  profiles/<app-slug>/     # isolated browser profile per app
    user.js                # Firefox: auto-generated profile preferences
    profile.json           # per-app metadata: browser, browser_type, gamepad,
                            #   nice/ionice, custom_icon flag, last_launched timestamp
    installed.marker       # presence flag used by list_installed_apps()
  scripts/                 # generated launcher shell wrappers
  .backup/<app-slug>/      # timestamped .tar.gz backup archives
```

Each installed app gets a shell wrapper in `scripts/` that handles nice/ionice process priority, GPU acceleration flags, WebHID flags for gamepad support, and Wayland or X11 display backend flags. A `.desktop` file is written to `~/.local/share/applications/` so the app appears in your application launcher with its own icon, stored in `~/.local/share/icons/hicolor/512x512/apps/`.

Browser detection checks for native installs, Flatpak, and Snap in that order. The profile size displayed in the UI is measured by walking the profile directory; no external tools are required. Wrapper regeneration reads `profile.json` for per-app settings, so the regenerated script is identical to what would be produced by a fresh install with those same settings.

For Firefox specifically, Appify writes a `user.js` to the profile directory that suppresses all first-run UI, telemetry, sync prompts, and new-tab page content and sets the homepage to your app's URL. This file is rewritten on every install so that new preferences added in future Appify versions are applied to existing profiles automatically. If you want to add your own Firefox preferences to a profile, put them in a `user-overrides.js` file in the same directory rather than editing `user.js` directly.

**userChrome.css / userContent.css:** text pasted into the Firefox Advanced Options fields is written verbatim to `<profile>/chrome/userChrome.css` and `<profile>/chrome/userContent.css`, and `toolkit.legacyUserProfileCustomizations.stylesheets` is set in that app's `user.js` automatically. This is a raw paste field, not a file picker — copy the CSS text from a layout on [firefoxcss-store.github.io](https://firefoxcss-store.github.io/) and paste it in directly. Only CSS is supported; layouts that require an accompanying `.js` file won't fully apply through Appify.

**Custom icons:** setting a custom icon (via Browse, next to the Browser selector) writes directly into the app's icon slot and sets a `custom_icon` flag in that app's `profile.json`, so future installs/reinstalls won't silently overwrite it with an auto-downloaded favicon. Reset to Auto clears the flag and re-downloads the favicon.

**Self-update:** Appify checks the GitHub Releases API on startup in a background thread and shows a banner if a newer stable release is available. **☰ Menu → Update Settings…** goes further: it detects whether you're running the `.deb` or the AppImage (via `dpkg` or the `$APPIMAGE` environment variable), can download and install an update in place with one click, and can install a `systemd` timer (`appify-updater.sh` / `.service` / `.timer`, written to `/usr/local/bin` and `/etc/systemd/system` via a single `pkexec` prompt) so Appify checks on a schedule you choose — hourly, daily at a specific time, weekly, or a custom `OnCalendar` expression — with no manual file editing required.

---

## Community and Support

- **Discord:** [Join Here](https://discord.gg/7fEt5W7DPh)
- **Patreon (Beta Builds):** [Patreon](https://www.patreon.com/c/BobbyComet/membership)
- **Support the Griffin Project:** [Ko-fi](https://ko-fi.com/bobby60908)

Appify is part of the [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).
