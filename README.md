<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

# Appify

**Turn any website into a real desktop app. Installs in under a second.**

**Each site gets its own browser, its own extensions, and its own space, automatically.**

Uses your already-installed browser. Nothing bundled, nothing duplicated.

Great for streaming tools, cloud gaming, work apps, and keeping personal and work sites separate (cloning feature makes this possible)

No Electron wrappers. No shared browser mess. No setup wizards. Just pick a site, click Install, and it's there, working like a native app, completely separate from everything else.

---

## How It Works

Appify is fully GUI-controlled. Here's the entire process:

1. Open Appify and search for your app, or pick one from the built-in list of 90+ sites
2. Appify creates a ghost profile instantly, using zero disk space until you need it
3. Choose your browser from whatever you have installed; Appify detects them automatically
4. Optionally, pick an extension preset (Appify opens that browser instance so you can configure it just like you normally would), you can also add your own via the add custom button
5. Click Install

That's it. In under a second, you have a real, working desktop app.
Typical install time: 0.6 seconds (see showcase video)

No loading bars. No account creation. No permissions screens. It just works.

[Video showcase](https://youtu.be/sCyWKTz_7Go?si=bcjcPYgJ3QqXZH2N)

<img width="1920" height="1080" alt="Appify2 1" src="https://github.com/user-attachments/assets/aee8cceb-7926-4c92-a0ee-c618a017205a" />

---

## Why Not Just Pin a Website?

When Chrome or Edge "installs" a website as an app, they're not really making an app. They create a shortcut that still runs inside your main browser profile, sharing the same cookies, the same extensions, the same telemetry, and the same taskbar clutter ("Edge is open 12 times").

Appify creates something genuinely separate for each site:

- Its own profile folder, cookies, logins, history, and storage
- Its own extensions, so you can install BTTV/7TV only on Twitch, uBlock only on YouTube, and keep your main browser lean
- Its own window with its own icon, grouped independently on your taskbar (see image below)
- Runs your real installed browser (Firefox, Brave, Edge, Ungoogled, and more) with proper Wayland/X11 support
- Kiosk mode, WebHID/gamepad support, and nice/ionice tuning for cloud gaming
- No Electron wrappers

<img width="755" height="42" alt="Icons" src="https://github.com/user-attachments/assets/69154b08-d715-43e3-ac74-e8a9379e4c07" />

> ** Quick heads-up before backing up**
Appify can back up your logins, cookies, history and site data — but not the extensions you've added.Browsers keep extension settings in special hidden folders separate from the profile, so we can't safely include them. Trying to back up with extensions installed will usually fail or crash.Easy fix:
Go to the app/site → open its browser settings → remove extensions first
Create the backup
After restoring later, just reinstall your favorite extensions (they'll usually remember your settings if you're signed in)
Sorry for the extra step — it's a browser limitation we can't work around, but your core data is still fully protected!

2.1.1 Fixed a bug of adding custom extensions and opening the store in the main browser; it will now open in the proper PWA instance and save it. 

---

## What Modern PWA Features Do You Keep?

Appify launches your real installed browser, so you get every native PWA capability that the browser supports, including auto-updates from the site manifest, offline support via service workers, push notifications, and account sync.

| Browser | Auto-Updates | Offline / Service Worker | Push Notifications (via settings in browser instance) | Account Sync | Notes |
|---|---|---|---|---|---|
| **Firefox** | Yes | Yes | Yes | Firefox Sync (passwords, history, tabs, add-ons) | Best gamepad support; native Wayland; per-app extensions shine here |
| **Microsoft Edge** | Yes | Yes | Yes | Microsoft account (passwords, history, extensions, collections) | Tight Windows integration (coming soon); good default for many users |
| **Brave** | Yes | Yes | Yes | Brave Sync (bookmarks, passwords, settings) | Built-in ad/tracker blocking; strong isolation synergy |
| **Vivaldi** | Yes | Yes | Yes | Vivaldi Sync (bookmarks, passwords, notes, tabs) | Highly customizable UI; tab stacking/notes carry over |
| **Google Chrome** | Yes | Yes | Yes | Google account (full: passwords, history, extensions, tabs, payments) | Widest extension ecosystem; seamless Google integration |
| **Chromium** | Yes | Yes | Yes | Depends on distro/build | Open-source base; no Google telemetry by default |
| **Opera** | Yes | Yes | Yes | Opera account (bookmarks, passwords, tabs, messengers) | Built-in VPN/messenger sidebar carries over |
| **Ungoogled Chromium** | Yes | Yes | Yes | Manual or via Google account | Maximum privacy; ideal for isolation purists |

You get the full modern web-platform experience, auto-updates, offline caching, push notifications, and account sync, without the shared-profile downsides of built-in Chrome/Edge PWAs.

---

## What's New in 2.1.0

2.1.0 is a focused security, stability, and compositor-awareness release. The UI and core feature set are unchanged from 2.0.x; this release hardens how Appify stores data, launches browsers, and handles the wide variety of Wayland compositors in use today.

### Compositor-Aware Wayland Handling

2.0.5 applied generic Wayland flags to all Wayland sessions without knowing what compositor was running. 2.1.0 detects your compositor and applies the right flags automatically:

| Compositor | Detection Method | Special Handling |
|---|---|---|
| **GNOME / Mutter** | `XDG_CURRENT_DESKTOP`, process scan | Standard ozone flags + CSD |
| **KDE Plasma / KWin** | `XDG_CURRENT_DESKTOP`, `kwin_wayland` process | Adds `GTK_USE_PORTAL=1` for Firefox kiosk; server-side decorations |
| **Sway** | `SWAYSOCK` env var, process scan | `WaylandWindowDecorations` + `--enable-wayland-ime` |
| **Hyprland** | `HYPRLAND_INSTANCE_SIGNATURE` env var | `WaylandWindowDecorations` + `--enable-wayland-ime` |
| **COSMIC** | `XDG_CURRENT_DESKTOP`, `cosmic-comp` process | Standard ozone flags + CSD |
| **Wayfire** | `DESKTOP_SESSION`, process scan | `WaylandWindowDecorations` + `--enable-wayland-ime` |
| **River** | `DESKTOP_SESSION`, process scan | `WaylandWindowDecorations` + `--enable-wayland-ime` |
| **labwc** | `DESKTOP_SESSION`, process scan | `WaylandWindowDecorations` + `--enable-wayland-ime` |
| **Unknown** | fallback | `--ozone-platform-hint=auto` |

Detection uses the cheapest path first (known environment variables, then `XDG_CURRENT_DESKTOP`/`DESKTOP_SESSION`, then a live process scan) with a fast 2-second timeout so startup is never delayed.

Firefox on Wayland also receives compositor-specific treatment. On KDE, `GTK_USE_PORTAL=1` is added alongside `MOZ_ENABLE_WAYLAND=1` so portal-based file pickers and system dialogs work correctly.

### Secure Profile Data Storage

In 2.0.5, profile directories and config files were created with default filesystem permissions. In 2.1.0:

- **Profile directories** are created with `chmod 0o700` (owner-only access, no other users on the system can read your PWA cookies, logins, or history)
- **`config.json`** is written atomically via a `.tmp` rename swap, and the live file is set to `chmod 0o600` before the rename completes, so it is never world-readable even for a fraction of a second
- **`profile.json`** follows the same atomic write + `0o600` pattern

### Safer Config Writes (Atomic, Crash-Resistant)

2.0.5 wrote `config.json` directly with `Path.write_text()`. A crash mid-write could leave the config truncated or corrupt. 2.1.0 uses a write-to-temp then atomic-rename pattern for every config file:

```
write JSON to config.json.tmp (0o600)
os.rename(tmp to config.json)   ← atomic on POSIX
```

A crash or power loss during a save now leaves the previous config intact. The `.tmp` file is cleaned up automatically on failure.

### Shell Injection Hardening

The launcher scripts Appify generates embed user-supplied values (URLs, app names, profile paths). In 2.1.0, all such values pass through `sanitize_shell_string()`, a strict allowlist filter that strips shell metacharacters, and are also placed inside quoted shell variables in the generated script. This is a defence-in-depth measure: even if the allowlist misses an edge case, the quoting prevents injection.

`download_file()` (used for icon fetching) now restricts curl to `https,http` protocols only, caps downloads at 2 MB, and validates downloaded icons with a magic-byte check (PNG/ICO/JPEG/GIF/WebP/BMP) before keeping them.

### Firefox Profile Pre-Initialisation

In 2.0.5, Firefox profiles were created as empty directories. On first launch, Firefox would show its welcome screen, account setup prompts, and telemetry consent dialogs before opening the PWA URL. 2.1.0 seeds each new Firefox profile with a `user.js` file that disables all of that on creation, sets the startup homepage to the PWA's URL, and clears `toolkit.singletonWindowType` so multiple isolated Firefox profiles can each hold their own window simultaneously. The `user.js` is only written if it does not already exist, so any manual edits you make to an existing profile are preserved.

### Internationalisation (i18n) Support

2.1.0 adds a full gettext-based translation system. On startup, Appify detects your system language via `LC_ALL`, `LANGUAGE`, and `LANG` and searches all standard locale directories across major Linux distros. If no translation exists for your language, Appify falls back to English with no errors.

To contribute a translation:

```bash
# 1. Extract strings
xgettext -L Python -o appify.pot Appify.py

# 2. Create a .po file for your language
msginit -l de_DE -o locale/de_DE/LC_MESSAGES/appify.po

# 3. Translate and compile
msgfmt locale/de_DE/LC_MESSAGES/appify.po -o locale/de_DE/LC_MESSAGES/appify.mo

# 4. Install
cp locale/de_DE/LC_MESSAGES/appify.mo /usr/share/locale/de_DE/LC_MESSAGES/
```

### Expanded Preset App Library

2.0.5 shipped a focused set of presets. 2.1.0 nearly triples the built-in app list with new categories:

| New Category | Apps Added |
|---|---|
| **Productivity** | Google Drive, Google Keep, Google Calendar, OneDrive, Outlook Web, Microsoft 365, ClickUp, Trello, Todoist, TickTick, Miro, Canva, Lucidchart, Excalidraw, diagrams.net |
| **Communication** | Slack, Microsoft Teams, Zoom Web, Google Meet |
| **Social** | X / Twitter, Instagram, Facebook, LinkedIn, Pinterest, Bluesky, 5MIND |
| **Streaming** | YouTube Music, Disney+, Prime Video, Hulu, Max (HBO), Peacock, Paramount+, Apple TV+, Plex Web, Stremio Web, Crunchyroll, AniWatch, Hianime, Rumble, Capcut |
| **Art & Creation** | Photopea, Figma, Clip Studio Paint Web, Sketchfab, Pixlr Editor, Remove.bg |
| **Utilities** | Google Translate, DeepL, Speedtest.net, Fast.com, Pomofocus Timer, myNoise, Rainy Mood, Radio Garden, ILovePDF, TinyPNG, Khan Academy, Duolingo, Yummly |
| **Shopping** | Amazon, eBay, AliExpress, Walmart, Target, Best Buy, Etsy, Trivago, Uber Web |
| **News** | Wikipedia, BBC News, Reuters, The Verge, TechCrunch, Hacker News, Wolfram Alpha, CNN, NYT, Washington Post, Forbes |
| **VTuber & Streaming Tools** | Streamelements, Ko-fi, Patreon, Throne (Wishlist), YouTube Studio |

### Extension Preset Expansion

2.0.5 had presets for Twitch, Kick, YouTube, Google Docs, and Google Slides. 2.1.0 adds:

- **Google Calendar:** Event Merge
- **Google Docs** presets updated with Grammar & Spell Check (LanguageTool), Super Styles, and Code Blocks

### URL Validation Hardening

`validate_url()` now explicitly rejects `data:`, `file:`, `javascript:`, and any other non-http/https scheme. URLs are also capped at 2,048 characters.

### Improved Logging

The module-level logger now attaches a `FileHandler` lazily, waiting until `~/.pwa_manager/launch.log`'s parent directory exists before writing. This prevents spurious warnings on a fresh install. All log messages now use structured `%(asctime)s [%(levelname)s] %(message)s` formatting with ISO timestamps.

---

## Quick Comparison: 2.0.5 vs 2.1.0

| Feature | 2.0.5 | 2.1.0 |
|---|---|---|
| Wayland compositor detection | Generic flags for all compositors | Per-compositor (GNOME, KDE, Sway, Hyprland, COSMIC, Wayfire, River, labwc) |
| Firefox kiosk on KDE Wayland | Broken (missing portal flags) | `GTK_USE_PORTAL=1` added automatically |
| Profile directory permissions | Default (world-readable) | `chmod 0700` (owner-only) |
| Config file permissions | Default | `chmod 0600`, atomic write |
| Config write safety | Direct `write_text()` | Atomic tmp rename (crash-safe) |
| Shell injection hardening | Basic sanitisation | Allowlist filter + quoted shell variables |
| Icon download security | No validation | Magic-byte check, protocol allowlist, 2 MB cap |
| Firefox first-run experience | Welcome screens, telemetry dialogs | Suppressed via `user.js` seed |
| Firefox multi-instance | Unreliable | `toolkit.singletonWindowType` cleared |
| Internationalisation (i18n) | No | Full gettext system, all major distro locale paths |
| Preset app count | ~30 apps | 90+ apps across 11 categories |
| Google Calendar extensions | No | Event Merge preset added |
| URL scheme validation | Basic | Blocks `data:`, `file:`, `javascript:` and others |
| Logging | File handler always attached | Lazy attach after config dir exists |
| Windows support | No | Coming soon |
| Profile isolation | Yes | Yes |
| 8-browser detection | Yes | Yes |
| GTK4 / Adwaita UI | Yes | Yes |
| Extension presets | Yes | Yes (expanded) |
| Cloud gaming presets | Yes | Yes |
| App cloning | Yes | Yes |
| Auto icon download | Yes | Yes (hardened) |
| Update banner | Yes | Yes |
| WebHID / gamepad support | Yes | Yes |

---

## What Stayed the Same

Everything that made Appify useful in 2.0.5 is still here, unchanged:

- **8 browsers fully detected:** Firefox, Edge, Brave, Vivaldi, Chrome, Chromium, Opera, Ungoogled Chromium, native, Flatpak, and Snap
- **Intelligent browser detection** at startup (no hardcoded paths)
- **System default browser auto-detection** via `xdg-settings`, `mimeapps.list`, and `gio`
- **Isolated profiles:** every PWA gets its own `~/.pwa_manager/profiles/<slug>/` with separate cookies, logins, and storage
- **Profile data preserved on uninstall:** reinstalling a PWA restores all your data
- **The GTK4 / Adwaita UI:** same layout, dark mode, app combo, kiosk toggle, GPU toggle, nice/ionice spinners
- **Extension presets:** Twitch, Kick, YouTube, Google Docs, and more
- **Custom PWA installation:** paste any URL, give it a name
- **App cloning:** duplicate any PWA with its own isolated profile
- **Cloud gaming presets:** Xbox Cloud Gaming, GeForce NOW, Amazon Luna, Boosteroid, AirGPU with kiosk mode and Firefox-first recommendations
- **Full WebHID / gamepad flag stack:** `--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist`
- **Auto icon download:** icon.horse, Google favicons, and direct favicon.ico fallback chain, now with magic-byte validation
- **Correct `.desktop` files:** `StartupWMClass`, `X-DBus-Name`, `TryExec`, and proper category flags
- **Update banner:** checks GitHub Releases on launch and notifies you of newer versions (skips pre-releases)
- **Full logging:** all launches write to `~/.pwa_manager/launch.log`
- **No Flatpak version of Appify itself:** sandboxing still breaks browser detection, extension installation, profile isolation, Wayland/X11 switching, and controller support

---

## Installation

**Windows port is coming soon.** Appify's isolation model, browser detection, and PWA launching are being adapted for Windows. Stay tuned on Discord and Patreon for updates.

### AppImage

Works on any modern Linux distribution with FUSE support, including Ubuntu 20.04+, Linux Mint 20+, Pop!_OS 20.04+, Zorin OS 16+, elementary OS 6+, Debian 11+, Fedora 35+, openSUSE Leap 15.3+ / Tumbleweed, Arch / Manjaro / EndeavourOS, and any other `x86_64` distro with glibc 2.31+.

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v2.1.0/Appify-2.1.0-x86_64.AppImage
chmod +x Appify-x86_64.AppImage
./Appify-x86_64.AppImage
```

### Deb Package

Works on Debian/Ubuntu-based distributions: Ubuntu 20.04 LTS+, Debian 11+, Linux Mint 20+, Pop!_OS 20.04+, Zorin OS 16+, elementary OS 6+, Kali Linux (rolling), and Raspberry Pi OS (Bullseye+, arm64).

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v2.1.0/Appify-2.1.0.deb
# Recommended: use gdebi to auto-resolve dependencies
sudo apt install gdebi
sudo gdebi Appify-2.1.0.deb
```

```bash
# Alternative: dpkg + fix-broken
sudo dpkg -i Appify-2.1.0.deb
sudo apt --fix-broken install -y
```

### Running from Source

Install the required dependencies for your distro first:

**Debian / Ubuntu / Mint / Pop!_OS / Zorin:**
```bash
sudo apt update
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-4.0 gir1.2-adw-1 curl xdg-utils
```

**Fedora / RHEL / CentOS:**
```bash
sudo dnf install python3-gobject gtk4 libadwaita curl xdg-utils
```

**Arch / Manjaro / EndeavourOS:**
```bash
sudo pacman -S python-gobject gtk4 libadwaita curl xdg-utils
```

**openSUSE Leap / Tumbleweed:**
```bash
sudo zypper install python3-gobject typelib-1_0-Gtk-4_0 typelib-1_0-Adw-1 curl xdg-utils
```

Then:
```bash
chmod +x Appify.py
python3 Appify.py
```

---

## Community & Support

- **Discord:** https://discord.gg/7fEt5W7DPh
- **Patreon (Beta Builds):** https://www.patreon.com/c/BobbyComet/membership
- **Support the Griffin Project:** https://ko-fi.com/bobby60908
- **YouTube Showcase:** https://youtu.be/sCyWKTz_7Go

Full Changelog: [v2.0.5 to v2.1.0](https://github.com/bobbycomet/Appify/compare/v2.0.5...v2.1.0)
