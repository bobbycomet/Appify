<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

<div align="center">

# Appify

**Search the defaults or paste a link, pick your browser, and click install. That’s it.**

**Every app runs in its own isolated profile with its own icon and launcher. Everything is handled automatically, but fully customizable if you want it.**

Version 2.2.0 is now out with an added feature. Firefox userChrome.css support. **THIS IS AN ADVANCED AND FRAGILE FEATURE! This is not Appify's fault.** userChrome.css can break as quickly as it is made. This is because of how Firefox changes and updates. If you use them, I do not have a store or any defaults. This is an **OPT-IN** feature only; you can ignore it.

Better Nvidia support for X11 on Firefox and Chromium-based browsers.

[![Latest Release](https://img.shields.io/badge/release-v2.1.4-blue)](https://github.com/bobbycomet/Appify/releases/tag/v2.1.4)
[![Part of Griffin Linux](https://img.shields.io/badge/project-Griffin%20Linux-purple)](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/)

[Video Showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N) | [Full Comparison Table](https://bobbycomet.github.io/Appify/) | [Discord](https://discord.gg/7fEt5W7DPh)

</div>

<img width="1920" height="1080" alt="Screenshot_20260414_022537" src="https://github.com/user-attachments/assets/3ad375f1-d641-40df-b83f-d1fd275cd8db" />

userChrome.css advanced feature
<img width="1920" height="1080" alt="Screenshot_20260421_050304" src="https://github.com/user-attachments/assets/892af248-9dbe-421f-bd25-eb93e2658ec0" />

---

>**Note:** Version 2.1.3 was withdrawn due to a race condition causing a black screen in some setups.
This was fixed in 2.1.4 along with additional stability improvements.

## Why Does This Exist?

Linux is the best desktop operating system for a lot of people. But one thing it has always lacked compared to Windows and macOS is a simple way to install web apps as real desktop apps with their own icons, taskbar entries, and isolated profiles.

The usual workarounds are messy. Chromium-based browsers have a "Create shortcut" option that technically works, but it ties your app to your main browser profile with no isolation. Firefox has nothing built in at all. Tools like GNOME Web and nativefier exist but require extra setup, have limited browser support, or rely on fragile hacks like userChrome.css that break silently every few Firefox updates.

Appify was built because none of those solutions were actually good. It gives you isolated, real desktop apps from any URL, using whichever browser you already have installed, with no manual config files, no terminal commands, and no breakage after browser updates.

Appify is part of the larger [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).

---

## A Note for Windows Users

If you are coming from Windows, one thing to know: Linux has two main ways to distribute apps. A `.deb` file is like an installer, the equivalent of a `.exe` setup wizard. An `.AppImage` is a self-contained portable file you can just run directly without installing anything, similar to a portable `.exe`. If you are on Ubuntu, Linux Mint, Pop!_OS, or any Debian-based distro, the `.deb` is the recommended choice. If your distro is not listed below or you just want something portable, the AppImage will work on almost any modern Linux system.

---

## How It Works

Appify is fully GUI-controlled. Open the app, and the entire process looks like this:

1. Search for a site by name, or pick from the built-in list of 90+ popular sites
2. Appify creates an isolated browser profile instantly, using zero disk space until the app is actually launched
3. Choose which browser to use. Appify automatically detects every browser you have installed, including native, Flatpak, and Snap versions
4. Optionally pick an extension preset for the site (SponsorBlock for YouTube, BetterTTV for Twitch, etc.). Appify opens that specific browser instance so you can configure extensions just like normal. You can also add your own via the Add Custom button
5. Click Install

That is it. Typical install time is 0.6 seconds. No loading bars. No account creation. No permissions screens.

[Watch the video showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N) | [See the full comparison table](https://bobbycomet.github.io/Appify/)

---

## Firefox PWAs Without userChrome.css

If you have tried to turn Firefox into a PWA launcher before, you have probably run into userChrome.css. It is the traditional approach for hiding the browser chrome and making Firefox look more like a standalone app. The problem is that it is fragile. Firefox updates frequently change the internal structure of the UI, and userChrome.css edits that worked perfectly last month can silently break, leaving you with a weird-looking, broken window and no obvious way to fix it.

Appify does not use userChrome.css by default. This is a purely opt-in feature. It defaults to the basic UI, unless cloud gaming, it uses Firefox's `--kiosk` (see cloud gaming section below) flag combined with isolated profile directories and a pre-configured `user.js` file that Appify writes automatically. Each app gets its own Firefox profile with startup telemetry disabled, the homepage locked to your app's URL, and all first-run UI suppressed. The profile is fully isolated from your regular Firefox, so your main browser, bookmarks, and history are never touched.

This approach is stable across Firefox updates because it uses documented, supported Firefox features rather than internal CSS hooks.

---

## Cloud Gaming and Kiosk Mode

Kiosk mode is included in Appify specifically because of cloud gaming. When you install a cloud gaming app like Xbox Cloud Gaming, GeForce NOW, or Amazon Luna through Appify with kiosk mode enabled, it launches in a true full-screen dedicated window with no browser chrome, no tab bar, and no address bar. It behaves exactly like a native game launcher.

**Firefox is the recommended browser for most cloud gaming services.** The reason is gamepad support. Firefox has native gamepad support built in that works without any special flags or workarounds. Chromium-based browsers (Chrome, Edge, Brave, etc.) require WebHID flags (which Appify handles) to be explicitly enabled, and on Linux, those flags also require the xdg-desktop-portal daemon and a matching desktop environment backend to be running before device permission dialogs can appear. If that portal stack is not set up correctly, your controller may be silently ignored with no error message.

Xbox Cloud Gaming is the one exception. Because Xcloud still has limitations in Chromium-based browsers, even with the correct flags, and WebHID gamepad support in Chromium requires extra setup on Linux, **Xbox Cloud Gaming in Appify defaults to a Chromium-based browser with WebHID flags pre-configured.** Appify handles all of this automatically, including checking whether your portal stack is ready and warning you in the UI if it is not.

For Xbox's Xcloud, GeForce NOW, Amazon Luna, Boosteroid, and AirGPU, Appify defaults those entries to Firefox for the most reliable out-of-the-box controller experience.

---

## Downloading and Installing

**Latest version: 2.2.0**

**Debian/Ubuntu/Linux Mint/Pop!_OS and other Debian-based distros:**

Download the `.deb` and install it:

```
wget https://github.com/bobbycomet/Appify/releases/download/v2.2.0/Appify-2.2.0.deb
sudo dpkg -i Appify-2.2.0.deb
sudo apt-get install -f   # fixes any missing dependencies
```

Or open the `.deb` file with your software manager if it supports package installation directly. Gdebi is also a solid choice

**All other distros (Arch, Fedora, openSUSE, NixOS, etc.) and portable use:**

Download the AppImage:

```
https://github.com/bobbycomet/Appify/releases/download/v2.2.0/Appify-2.2.0-x86_64.AppImage
```

Make it executable and run it:

```
chmod +x Appify-x86_64.AppImage
./Appify-x86_64.AppImage
```

You can move the AppImage anywhere you like and it will run from there. No installation required.

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

**Important:** Before creating a backup, any extensions you have added to that app's browser profile must be removed first. This is a browser limitation, not an Appify one. Browser extensions store their files inside the profile directory in a way that can produce inconsistent archive states if they are present during the backup. Remove the extensions from the profile, take a backup, then reinstall the extensions afterward if needed. You can also move a backup to another computer, put it in the backup folder, and Appify will see it.

---

## Technical Details

Appify stores its configuration and all app profiles in `~/.config/appify/`. The structure looks like this:

```
~/.config/appify/
  config.json              # global settings and app registry
  profiles/<app-slug>/     # isolated browser profile per app
    user.js                # Firefox: auto-generated profile preferences
    profile.json           # per-app metadata (browser, gamepad flag, etc.)
    installed.marker       # presence flag used by list_installed_apps()
  scripts/                 # generated launcher shell wrappers
  .backup/<app-slug>/      # timestamped .tar.gz backup archives
```

Each installed app gets a shell wrapper in `scripts/` that handles nice/ionice process priority, GPU acceleration flags, WebHID flags for gamepad support, and Wayland or X11 display backend flags. A `.desktop` file is written to `~/.local/share/applications/` so the app appears in your application launcher with its own icon.

Browser detection checks for native installs, Flatpak, and Snap in that order. For Firefox specifically, Appify writes a `user.js` to the profile directory that suppresses all first-run UI, telemetry, sync prompts, and new-tab page content, and sets the homepage to your app's URL. This file is rewritten on every install so that new preferences added in future Appify versions are applied to existing profiles automatically. If you want to add your own Firefox preferences to a profile, put them in a `user-overrides.js` file in the same directory rather than editing `user.js` directly.

Appify checks for updates against the GitHub Releases API on startup in a background thread and notifies you in the UI if a newer stable release is available.

---

## Community and Support

- **Discord:** [Join Here](https://discord.gg/7fEt5W7DPh)
- **Patreon (Beta Builds):** [Patreon](https://www.patreon.com/c/BobbyComet/membership)
- **Support the Griffin Project:** [Ko-fi](https://ko-fi.com/bobby60908)

Appify is part of the [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).
