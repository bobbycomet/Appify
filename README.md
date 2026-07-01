<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

<div align="center">

# Appify

**Search the defaults or paste a link, pick your browser, and click install. That's it.**

**Every app runs in its own isolated profile with its own icon and launcher. Everything is handled automatically, but fully customizable if you want it.**

**3.0 is coming with new features and a new PyQt6 look.**

**READ 2.2.3 UPDATES IN THE FAQS AND DEBUGGING IF YOU ARE A CURRENT USER THAT RAN INTO MIGRATION ISSUES:[FAQS](https://github.com/bobbycomet/Appify/wiki/FAQs) [DEBUGGING](https://github.com/bobbycomet/Appify/wiki/How-to-debug)**

[![Latest Release](https://img.shields.io/badge/release-v2.2.2-blue)](https://github.com/bobbycomet/Appify/releases/tag/v2.2.2)
[![Part of Griffin Linux](https://img.shields.io/badge/project-Griffin%20Linux-purple)](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/)

[Video Showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N) | [Full Comparison Table](https://bobbycomet.github.io/Appify/) | [Discord](https://discord.gg/7fEt5W7DPh)

### The Old VS New Look

</div>

<img width="1920" height="1080" alt="Screenshot_20260414_022537" src="https://github.com/user-attachments/assets/3ad375f1-d641-40df-b83f-d1fd275cd8db" />

<img width="1920" height="1080" alt="Screenshot_20260611_172303" src="https://github.com/user-attachments/assets/3f9be47c-bd16-4a6f-911d-7a652abf2f3a" />

<img width="1920" height="1080" alt="Screenshot_20260611_172251" src="https://github.com/user-attachments/assets/9021b2bd-9a8a-4a53-9ea6-afd1a3e3f12a" />

---
Search the defaults or paste a link, pick your browser, and click install. That's it.

Appify turns websites into real desktop apps with their own icons, launchers, and isolated browser profiles. Everything is handled automatically, but remains fully customizable if you want more control.

Whether you're installing a built-in app or creating your own, the workflow is the same:

Choose an app (or click install custom and paste a URL)
Pick a browser
Click Install

Need extensions? Use a premade profile if the app has one, click Open Store, or paste an extension URL with Add Custom.

Appify automatically detects app names from URLs, so pasting a link like GitHub automatically creates a GitHub app without any extra setup.

Typical Setup Times
Basic app: 10–20 seconds
App + extensions: 60 seconds
Fully custom setup: 90 seconds

Included Categories
Cloud Gaming
Social Media
Google Workspace
Streaming
Communication
Productivity (including Google Workspaces)
AI & Search
Utilities
Shopping
News & Knowledge

Key New Features in 2.2.3
1. Config Directory Migration (~/.pwa_manager → ~/.appify)

- The default data directory has been renamed from ~/.pwa_manager to ~/.appify for better naming clarity.
- Safe, user-controlled migration:
- On first launch, a confirmation dialog appears.
- Users can also trigger migration anytime via the hamburger menu (Migrate to .appify…).
- The old directory is not deleted until the user confirms the migration.

- After migration, a clear notice explains that browser extensions may need repair (a browser sandbox limitation).

2. Export / Import System

- Export All Data: Creates a zip archive of your entire ~/.appify folder (profiles, scripts, backups, config, etc.).
- Import All Data: Restores from a previous export.
- Automatically backs up your current data first.
- Regenerates all launcher wrappers for the current machine (different browsers, Wayland/X11, Flatpak/Snap, etc.).

- Export includes a warning that browser extensions cannot be transferred due to browser sandbox restrictions.

---

## What's New in 2.2.2

Three new features have been added. Everything that existed before still works exactly the same way; nothing was removed or changed in behavior.

| Feature | Before 2.2.2 | After 2.2.2 |
|---|---|---|
| **Finding apps** | Search by name only | Search by name **or** browse by category in a collapsible panel |
| **Profile storage info** | No indication of how much disk space a profile uses | Profile size shown directly below the app dropdown, updated when you switch apps |
| **After switching X11 ↔ Wayland** | Had to reinstall each app individually to fix launcher flags | New "Regenerate All Wrappers" menu action rewrites every installed app's launcher at once |
| App categories | Comments only, not surfaced in the UI | All 90+ built-in apps tagged across 11 categories; custom-added apps preserved as-is |
| Wrapper scripts | Embedded session type at install time, stale after session change | Same behavior at install; now trivially refreshable for all apps in one action |

### Browse by Category

A collapsible "Browse by Category" panel sits below the app search. Open it, pick a category from the dropdown, and you see every app in that group with a ✓ next to the ones already installed. Clicking Select on any app puts it into the main dropdown instantly — all the normal Install, Uninstall, Clone, and Backup buttons then act on it. The search box and the category browser work independently and do not interfere with each other.

The 11 categories are: AI & Search, Productivity, Communication, Social, Streaming, Cloud Gaming, Art & Design, Streaming Tools, Utilities, Shopping, and News & Knowledge.

### Profile Size Indicator

Just below the app selection dropdown, Appify now shows the current on-disk size of that app's profile directory. For example, "Profile size: 84.2 MB". The measurement runs in the background, so switching between apps never slows down the UI, even for large profiles. Apps that have not been installed yet show a dash.

### Regenerate All Wrappers

Each installed app has a small shell script that Appify generated at install time. That script includes the right display flags for whichever session type (X11 or Wayland) and browser installation method (native, Flatpak, or Snap) was active when you installed it. If you switch from X11 to Wayland, upgrade a browser from native to Flatpak, or make any other system-level change, those scripts can go stale.

Previously, the fix was to reinstall each app one by one. Now there is a single menu action — **Regenerate All Wrappers** — under the hamburger menu. It rewrites every installed app's launcher script and desktop file using your current system state, shows you the count when it finishes, and touches nothing else. No profile data, no cookies, no extensions, and no preferences are affected.

---

## Why Does This Exist?

Linux is the best desktop operating system for a lot of people. But one thing it has always lacked compared to Windows and macOS is a simple way to install web apps as real desktop apps with their own icons, taskbar entries, and isolated profiles.

The usual workarounds are messy. Chromium-based browsers have a "Create shortcut" option that technically works, but it ties your app to your main browser profile with no isolation. Firefox has nothing built in at all. Tools like GNOME Web and nativefier exist but require extra setup, have limited browser support, or rely on fragile hacks like userChrome.css that break silently every few Firefox updates.

Appify was built because none of those solutions were actually good. It gives you isolated, real desktop apps from any URL, using whichever browser you already have installed, with no manual config files, no terminal commands, and no breakage after browser updates.

Appify is part of the larger [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).

---

## A Note for Windows Users

If you are coming from Windows, one thing to know: Linux has two main ways to distribute apps. A `.deb` (each distro type has its own version of something similar) file is like an installer, the equivalent of a `.exe` setup wizard. An `.AppImage` is a self-contained portable file you can just run directly without installing anything, similar to a portable `.exe`. If you are on Ubuntu, Linux Mint, Pop!_OS, or any Debian-based distro, the `.deb` is the recommended choice. If your distro is not listed below or you just want something portable, the AppImage will work on almost any modern Linux system.

---

## How It Works

Appify is fully GUI-controlled. Open the app, and the entire process looks like this:

1. Search for a site by name, browse by category, or pick from the built-in list of 90+ popular sites
2. Appify creates an isolated browser profile instantly, using zero disk space until the app is actually launched
3. Choose which browser to use. Appify automatically detects every browser you have installed, including native, Flatpak, and Snap versions
4. Optionally pick an extension preset for the site (SponsorBlock for YouTube, BetterTTV for Twitch, etc.). Appify opens that specific browser instance so you can configure extensions just like normal. You can also add your own via the Add Custom button
5. Click Install

That is it. Typical install time is 0.6 seconds. No loading bars. No account creation. No permissions screens.

[Watch the video showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N) | [See the full comparison table](https://bobbycomet.github.io/Appify/)

---

## Firefox PWAs Without userChrome.css

If you have tried to turn Firefox into a PWA launcher before, you have probably run into userChrome.css. It is the traditional approach for hiding the browser chrome and making Firefox look more like a standalone app. The problem is that it is fragile. Firefox updates frequently change the internal structure of the UI, and userChrome.css edits that worked perfectly last month can silently break, leaving you with a weird-looking, broken window and no obvious way to fix it.

Appify does not use userChrome.css by default. It is a purely opt-in feature available under Firefox Advanced Options when Firefox is selected. By default, Appify uses Firefox's `--kiosk` flag (for cloud gaming) or a standard window combined with isolated profile directories and a pre-configured `user.js` file that Appify writes automatically. Each app gets its own Firefox profile with startup telemetry disabled, the homepage locked to your app's URL, and all first-run UI suppressed. The profile is fully isolated from your regular Firefox, so your main browser, bookmarks, and history are never touched.

This approach is stable across Firefox updates because it uses documented, supported Firefox features rather than internal CSS hooks.

> **Note on userChrome.css:** This is an advanced and fragile feature — not because of anything Appify does, but because of how Firefox itself works. userChrome.css can break with any Firefox update that changes the internal UI structure. If you use it, Appify has no control over whether it remains functional after a Firefox update. It is opt-in only and safe to ignore entirely.

---

## Cloud Gaming and Kiosk Mode

Kiosk mode is included in Appify specifically because of cloud gaming. When you install a cloud gaming app like Xbox Cloud Gaming, GeForce NOW, or Amazon Luna through Appify with kiosk mode enabled, it launches in a true full-screen dedicated window with no browser chrome, no tab bar, and no address bar. It behaves exactly like a native game launcher.

**Firefox is the recommended browser for most cloud gaming services.** The reason is gamepad support. Firefox has native gamepad support built in that works without any special flags or workarounds. Chromium-based browsers (Chrome, Edge, Brave, etc.) require WebHID flags, which Appify handles, to be explicitly enabled, and on Linux, those flags also require the xdg-desktop-portal daemon and a matching desktop environment backend to be running before device permission dialogs can appear. If that portal stack is not set up correctly, your controller may be silently ignored with no error message.

Xbox Cloud Gaming is the one exception. Appify defaults Xbox Cloud Gaming to a Chromium-based browser with WebHID flags pre-configured. Appify handles all of this automatically, including checking whether your portal stack is ready and warning you in the UI if it is not.

For GeForce NOW, Amazon Luna, Boosteroid, and AirGPU, Appify defaults those entries to Firefox for the most reliable out-of-the-box controller experience.

---

## Downloading and Installing

**Latest version: 2.2.3**

**Debian/Ubuntu/Linux Mint/Pop!_OS and other Debian-based distros:**

```
wget https://github.com/bobbycomet/Appify/releases/download/v2.2.3/Appify-2.2.3.deb
sudo dpkg -i Appify-2.2.3.deb
sudo apt-get install -f
```

Or open the `.deb` file with your software manager directly. Gdebi is also a solid choice.

**All other distros (Arch, Fedora, openSUSE, NixOS, etc.) and portable use:**

```
https://github.com/bobbycomet/Appify/releases/download/v2.2.3/Appify-2.2.3-x86_64.AppImage
```

```
chmod +x Appify-2.2.3-x86_64.AppImage
./Appify-2.2.3-x86_64.AppImage
```

You can move the AppImage anywhere you like, and it will run from there. No installation required.

---

## Supported Distros

Appify is tested and known to work on the following:

**Debian-based:** Ubuntu, Linux Mint, Pop!_OS, Zorin OS, elementary OS, Debian itself

**RPM-based:** Fedora, openSUSE, Nobara (use the AppImage)

**Arch-based:** Arch Linux, Manjaro, EndeavourOS (use the AppImage)

**Independent:** NixOS, Void Linux, and most other modern systemd-based distros (use the AppImage)

Appify requires Python 3.10 or later, GTK 4, and libadwaita. These are included when you use the `.deb` installer. For the AppImage, everything is bundled. For manual installs on other distros, the equivalent packages are `python3-gi`, `gir1.2-gtk-4.0`, and `gir1.2-adw-1`.

Wayland and X11 are both fully supported. Appify automatically detects your session type and configures browser launch flags accordingly, including compositor-specific flags for KDE Plasma, GNOME, Hyprland, Sway, COSMIC, and other Wayland environments.

---

## How Backups Work

Every installed app can be backed up from within Appify. A backup is a single `.tar.gz` archive that contains the entire browser profile directory (cookies, logins, preferences), the launcher script, the desktop file, the app icon, and a metadata sidecar. Backups are stored in `~/.config/appify/.backup/<app-name>/` and are timestamped so you can keep multiple restore points.

Appify keeps up to 10 backups per app automatically. When a new backup is created, and the limit is exceeded, the oldest backup is pruned. Restoring a backup wipes the current profile and replaces it, then regenerates the launcher and desktop file with your current system paths, so restores work cleanly even if you have moved things around.

> **Note:** Before creating a backup, any extensions you have added to that app's browser profile must be removed first. This is a browser limitation, not an Appify one. Browser extensions store their files inside the profile directory in a way that can produce inconsistent archive states if they are present during the backup. Remove the extensions, take the backup, then reinstall them afterward if needed. You can also move a backup to another computer, place it in the backup folder, and Appify will find it.

---

## Technical Details

Appify stores its configuration and all app profiles in `~/.config/appify/`. The structure looks like this:

```
~/.config/appify/
  config.json              # global settings and app registry
  profiles/<app-slug>/     # isolated browser profile per app
    user.js                # Firefox: auto-generated profile preferences
    profile.json           # per-app metadata (browser, gamepad flag, nice/ionice, etc.)
    installed.marker       # presence flag used by list_installed_apps()
  scripts/                 # generated launcher shell wrappers
  .backup/<app-slug>/      # timestamped .tar.gz backup archives
```

Each installed app gets a shell wrapper in `scripts/` that handles nice/ionice process priority, GPU acceleration flags, WebHID flags for gamepad support, and Wayland or X11 display backend flags. A `.desktop` file is written to `~/.local/share/applications/` so the app appears in your application launcher with its own icon.

Browser detection checks for native installs, Flatpak, and Snap in that order. The profile size displayed in the UI is measured by walking the profile directory, no external tools required. Wrapper regeneration reads `profile.json` for per-app settings, so the regenerated script is identical to what would be produced by a fresh install with those same settings.

For Firefox specifically, Appify writes a `user.js` to the profile directory that suppresses all first-run UI, telemetry, sync prompts, and new-tab page content, and sets the homepage to your app's URL. This file is rewritten on every install so that new preferences added in future Appify versions are applied to existing profiles automatically. If you want to add your own Firefox preferences to a profile, put them in a `user-overrides.js` file in the same directory rather than editing `user.js` directly.

Appify checks for updates against the GitHub Releases API on startup in a background thread and notifies you in the UI if a newer stable release is available.

---

## Community and Support

- **Discord:** [Join Here](https://discord.gg/7fEt5W7DPh)
- **Patreon (Beta Builds):** [Patreon](https://www.patreon.com/c/BobbyComet/membership)
- **Support the Griffin Project:** [Ko-fi](https://ko-fi.com/bobby60908)

Appify is part of the [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).
