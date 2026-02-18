<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>


Full Changelog: [channel log](https://github.com/bobbycomet/Appify/compare/v2.0.4...v2.0.5)

Appify doesn't just "pin a website" as Chrome or Edge does.

Those create a shortcut that still runs inside your main browser profile — same cookies, same extensions (loaded all the time), same telemetry, same taskbar grouping mess ("Edge is open 12 times"). Appify creates a real, isolated desktop app for each site:
Completely separate profile folder, its own cookies, logins, history, storage.

- Own extensions, install BTTV/7TV only on Twitch, uBlock only on YouTube, etc., your main browser stays lean
- Own window, proper panel (task bar for Windows when that version is finished) icon, groups independently, no "7 Edge icons" clutter
- Uses your real installed browser (Firefox, Brave, Edge, Ungoogled, etc.) with proper Wayland/X11 flags
- Kiosk mode, WebHID/gamepad support, nice/ionice tuning for cloud gaming
- no electron wrappers

### What Modern PWA Features Do I Keep with Each Supported Browser?

Appify launches your **real installed browser** (not a wrapper or limited engine), so you inherit **all** the native PWA capabilities that browser provides — including auto-updates from the site manifest, offline support via service workers, push notifications, and account/ecosystem sync.

Here's exactly what is preserved for each supported browser: 

| Browser                  | Auto-Updates from Manifest | Offline Handling (Service Worker) | Native Push Notifications | Account / Ecosystem Sync                  | Notes / Extra Perks in Appify                     |
|--------------------------|----------------------------|------------------------------------|---------------------------|-------------------------------------------|---------------------------------------------------|
| **Firefox**              | Yes                        | Yes                                | Yes                       | Firefox Sync (passwords, history, tabs, add-ons) | Best WebHID/gamepad support for cloud gaming; native Wayland; per-app extensions shine here |
| **Microsoft Edge**       | Yes                        | Yes                                | Yes                       | Microsoft account sync (passwords, history, extensions, collections) | Tight Windows integration (coming soon); good default for many users |
| **Brave**                | Yes                        | Yes                                | Yes                       | Brave Sync (limited: bookmarks, passwords, settings) | Built-in ad/tracker blocking; privacy-focused; strong isolation synergy |
| **Vivaldi**              | Yes                        | Yes                                | Yes                       | Vivaldi Sync (bookmarks, passwords, notes, tabs) | Highly customizable UI; tab stacking/notes carry over |
| **Google Chrome**        | Yes                        | Yes                                | Yes                       | Google account sync (full: passwords, history, extensions, tabs, payments) | Widest extension ecosystem; seamless Google service integration |
| **Chromium**             | Yes                        | Yes                                | Yes                       | Depends on distro/packages (often manual or via Google account if signed in) | Open-source base; no Google telemetry by default |
| **Opera**                | Yes                        | Yes                                | Yes                       | Opera account sync (bookmarks, passwords, tabs, messengers) | Built-in VPN/messenger sidebar carries over |
| **Ungoogled Chromium**   | Yes                        | Yes                                | Yes                       | Manual or via Google account if signed in (no forced sync) | Maximum privacy (no Google tracking); ideal for isolation purists |

**Bottom line**:  
No matter which browser you pick, Appify gives you **the full modern PWA experience** that browser supports — auto-updates, offline caching, push notifications, and account sync — **without** the shared-profile downsides of built-in Chrome/Edge PWAs (shared cookies/extensions/telemetry, no per-app extension control, taskbar clutter).

Appify adds the best of both worlds:  
- All the web-platform polish you expect  
- True per-PWA isolation, per-site extensions, independent desktop windows/icons, sub-second installs, backup/restore, and deep Linux integration (compositor-aware Wayland flags, etc.)

Still have questions about a specific browser or feature? Join the Discord or open an issue — happy to clarify!

<div align="center">
  <img src=https://github.com/bobbycomet/Appify/blob/main/Appify2.0.png
</div>

> **Windows port is coming soon.** Appify's isolation model, browser detection, and PWA launching are being adapted for Windows — stay tuned on Discord and Patreon for updates.

Full Changelog: [channel log](https://github.com/bobbycomet/Appify/compare/v2.0.5...v2.1.0)

---

# Appify 2.1.0 – What's New Over 2.0.5

2.1.0 is a focused security, stability, and compositor-awareness release. It does not change the UI or the core feature set — everything from 2.0.x is still here — but it hardens how Appify stores data, launches browsers, and handles the wide variety of Wayland compositors in use today.

---

## What's New in 2.1.0

### Compositor-Aware Wayland Handling

2.0.5 applied generic Wayland flags (`--ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations`) to all Wayland sessions without knowing what compositor was actually running.

2.1.0 introduces full compositor detection and applies the right flags per environment:

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

Detection uses the cheapest path first: known environment variables, then `XDG_CURRENT_DESKTOP`/`DESKTOP_SESSION`, then a live process scan — with a fast 2-second timeout so startup is never delayed.

Firefox on Wayland also receives compositor-specific treatment. On KDE, `GTK_USE_PORTAL=1` is added alongside `MOZ_ENABLE_WAYLAND=1` so portal-based file pickers and system dialogs work correctly.

### Secure Profile Data Storage

In 2.0.5, profile directories and config files were created with default filesystem permissions. In 2.1.0:

- **Profile directories** are created with `chmod 0o700` (owner-only access — no other users on the system can read your PWA cookies, logins, or history)
- **`config.json`** is written atomically via a `.tmp` → rename swap, and the live file is set to `chmod 0o600` before the rename completes — it is never world-readable, even for a fraction of a second
- **`profile.json`** (per-app config) follows the same atomic write + `0o600` pattern

This prevents other users or processes on a shared machine from reading your saved logins or session data.

### Safer Config Writes (Atomic, Crash-Resistant)

2.0.5 wrote `config.json` directly with `Path.write_text()`. If Appify crashed mid-write, the config could be left truncated or corrupt, requiring manual recovery.

2.1.0 uses a write-to-temp → atomic-rename pattern for every config file:

```
write JSON → config.json.tmp (0o600)
           → os.rename(tmp → config.json)   ← atomic on POSIX
```

A crash or power loss during a save now leaves the previous config intact. The `.tmp` file is cleaned up automatically on failure.

### Shell Injection Hardening

The launcher scripts Appify generates embed user-supplied values (URLs, app names, profile paths). In 2.1.0, all such values are passed through `sanitize_shell_string()` — a strict allowlist filter that strips shell metacharacters — and are also placed inside quoted shell variables in the script itself. This is a defence-in-depth measure: even if the allowlist misses an edge case in a future edit, the quoting prevents injection.

Additionally, `download_file()` (used for icon fetching) now restricts curl to `https,http` protocols only via `--proto https,http`, caps downloads at 2 MB with `--max-filesize`, and validates downloaded icons with a magic-byte check (PNG/ICO/JPEG/GIF/WebP/BMP) before keeping them. Non-image responses are deleted immediately.

### Firefox Profile Pre-Initialisation

In 2.0.5, Firefox profiles were created as empty directories. On first launch, Firefox would show its welcome screen, account setup prompts, and telemetry consent dialogs before opening the PWA URL — defeating the "instant app" experience.

2.1.0 seeds each new Firefox profile with a `user.js` file on creation. This file disables:

- First-run welcome screen and onboarding tour
- New-tab sponsored content and discovery stream
- Telemetry, health reports, and data submission
- Firefox Accounts / Sync UI (not needed for an isolated PWA profile)
- Extension recommendation panels
- Close/quit warning dialogs

It also sets the startup homepage to the PWA's URL and clears `toolkit.singletonWindowType` so multiple isolated Firefox profiles can each hold their own window open simultaneously. The `user.js` file is only written if it does not already exist, so any manual edits you make to an existing profile are preserved.

### Internationalisation (i18n) Support

2.1.0 adds a full gettext-based translation system. On startup, Appify detects your system language via `LC_ALL`, `LANGUAGE`, and `LANG` environment variables and searches all standard locale directories across major Linux distros (Debian/Ubuntu, Fedora/RHEL, Arch, Flatpak exports, AppImage bundle, and a local `./locale/` path for development).

If a matching `.mo` file is found, it is loaded silently. If no translation exists for your language, Appify falls back to English with no errors. All translatable strings in the UI are wrapped with `_()`.

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

- **Google Calendar**: Event Merge
- **Google Docs** presets updated with Grammar & Spell Check (LanguageTool), Super Styles, and Code Blocks

### URL Validation Hardening

`validate_url()` now explicitly rejects `data:`, `file:`, `javascript:`, and any other non-http/https scheme. URLs are also capped at 2,048 characters. This prevents malformed or malicious URLs from reaching the browser launcher.

### Improved Logging

The module-level logger now attaches a `FileHandler` lazily — it waits until `~/.pwa_manager/launch.log`'s parent directory exists before writing to disk. This prevents spurious warnings on a fresh install before the config directory has been created. All log messages now use structured `%(asctime)s [%(levelname)s] %(message)s` formatting with ISO timestamps.

---

## What Stayed the Same

Everything that made Appify useful in 2.0.5 is still here, unchanged:

- **8 browsers fully detected**: Firefox, Edge, Brave, Vivaldi, Chrome, Chromium, Opera, Ungoogled Chromium — native, Flatpak, and Snap
- **Intelligent browser detection** at startup (no hardcoded paths)
- **System default browser auto-detection** via `xdg-settings`, `mimeapps.list`, and `gio`
- **Isolated profiles** — every PWA gets its own `~/.pwa_manager/profiles/<slug>/` with separate cookies, logins, and storage
- **Profile data preserved on uninstall** — reinstalling a PWA restores all your data
- **The GTK4 / Adwaita UI** — same layout, dark mode, app combo, kiosk toggle, GPU toggle, nice/ionice spinners
- **Extension presets** — Twitch, Kick, YouTube, Google Docs, and more
- **Custom PWA installation** — paste any URL, give it a name
- **App cloning** — duplicate any PWA with its own isolated profile
- **Cloud gaming presets** — Xbox Cloud Gaming, GeForce NOW, Amazon Luna, Boosteroid, AirGPU with kiosk mode and Firefox-first recommendations
- **Full WebHID / gamepad flag stack** — `--enable-features=WebHID --enable-gamepad-button-axis-events --disable-features=WebHidBlocklist`
- **Auto icon download** — icon.horse → Google favicons → direct favicon.ico fallback chain, now with magic-byte validation
- **Correct `.desktop` files** — `StartupWMClass`, `X-DBus-Name`, `TryExec`, and proper category flags
- **Update banner** — checks GitHub Releases on launch and notifies you of newer versions (skips pre-releases)
- **Full logging** — all launches write to `~/.pwa_manager/launch.log`
- **No Flatpak version of Appify itself** — sandboxing still breaks browser detection, extension installation, profile isolation, Wayland/X11 switching, and controller support

---

## Quick Comparison: 2.0.5 vs 2.1.0

| Feature | 2.0.5 | 2.1.0 |
|---|---|---|
| Wayland compositor detection | ❌ Generic flags for all compositors | ✅ Per-compositor (GNOME, KDE, Sway, Hyprland, COSMIC, Wayfire, River, labwc) |
| Firefox kiosk on KDE Wayland | Broken (missing portal flags) | ✅ `GTK_USE_PORTAL=1` added automatically |
| Profile directory permissions | Default (world-readable) | ✅ `chmod 0700` (owner-only) |
| Config file permissions | Default | ✅ `chmod 0600`, atomic write |
| Config write safety | Direct `write_text()` | ✅ Atomic tmp → rename (crash-safe) |
| Shell injection hardening | Basic sanitisation | ✅ Allowlist filter + quoted shell variables |
| Icon download security | No validation | ✅ Magic-byte check, protocol allowlist, 2 MB cap |
| Firefox first-run experience | Welcome screens, telemetry dialogs | ✅ Suppressed via `user.js` seed |
| Firefox multi-instance | Unreliable | ✅ `toolkit.singletonWindowType` cleared |
| Internationalisation (i18n) | ❌ | ✅ Full gettext system, all major distro locale paths |
| Preset app count | ~30 apps | ✅ 90+ apps across 11 categories |
| Google Calendar extensions | ❌ | ✅ Event Merge preset added |
| URL scheme validation | Basic | ✅ Blocks `data:`, `file:`, `javascript:` and others |
| Logging | File handler always attached | ✅ Lazy attach after config dir exists |
| Windows support | ❌ | 🚧 Coming soon |
| Profile isolation | ✅ | ✅ |
| 8-browser detection | ✅ | ✅ |
| GTK4 / Adwaita UI | ✅ | ✅ |
| Extension presets | ✅ | ✅ (expanded) |
| Cloud gaming presets | ✅ | ✅ |
| App cloning | ✅ | ✅ |
| Auto icon download | ✅ | ✅ (hardened) |
| Update banner | ✅ | ✅ |
| WebHID / gamepad support | ✅ | ✅ |

## Community & Support

- **Discord:** https://discord.gg/7fEt5W7DPh
- **Patreon (Beta Builds):** https://www.patreon.com/c/BobbyComet/membership
- **Support the Griffin Project:** https://ko-fi.com/bobby60908
## Distro Compatibility

Appify is distributed as an **AppImage** and a **.deb** package.

### AppImage
Works on any modern Linux distribution with FUSE support, including:
- Ubuntu 20.04 and newer (and all Ubuntu flavors: Kubuntu, Xubuntu, Lubuntu, etc.)
- Linux Mint 20 and newer
- Pop!_OS 20.04 and newer
- Zorin OS 16 and newer
- elementary OS 6 and newer
- Debian 11 (Bullseye) and newer
- Fedora 35 and newer
- openSUSE Leap 15.3 and newer / Tumbleweed
- Arch Linux / Manjaro / EndeavourOS
- Any other `x86_64` Linux distro with glibc 2.31+

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v2.1.0/Appify-2.1.0-x86_64.AppImage
chmod +x Appify-x86_64.AppImage
./Appify-x86_64.AppImage
```

### Deb Package
Works on Debian/Ubuntu-based distributions:
- Ubuntu 20.04 LTS and newer
- Debian 11 (Bullseye) and newer
- Linux Mint 20 and newer
- Pop!_OS 20.04 and newer
- Zorin OS 16 and newer
- elementary OS 6 and newer
- Kali Linux (rolling)
- Raspberry Pi OS (Bullseye and newer, arm64)

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v2.1.0/Appify-2.1.0.deb
# Recommended: use gdebi to auto-resolve dependencies
sudo apt install gdebi
sudo gdebi Appify-2.0.0.deb
```

```bash
# Alternative: dpkg + fix-broken
sudo dpkg -i Appify-2.0.0.deb
sudo apt --fix-broken install -y
```

### Running from Source
For distros not covered above, run directly from the Python source. Install the required dependencies for your distro first:

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

## Quick Comparison: 1.x vs 2.0

| Feature | 1.x | 2.0 |
|---|---|---|
| Browser detection | Hardcoded commands | Runtime detection (native/Flatpak/Snap) |
| Default browser | Always Edge | Reads your system default |
| Wayland support | `--ozone-platform-hint=auto` guess | Proper per-session, per-browser flags |
| Firefox on Wayland | Forced to X11 | Native Wayland |
| Supported browsers | 4 configured, 6 listed | 8 fully configured and detected |
| Ungoogled Chromium | ❌ | ✅ |
| WebHID flags | Basic (`--enable-features=WebHID`) | Full 3-flag stack + display backend |
| Preset apps: AI | ❌ | ChatGPT, Claude, Grok, Gemini, Perplexity |
| YouTube extensions | 3 | 7 |
| Launcher script debug info | None | Session type + browser name in header |
| Per-app browser lock to Edge | Yes (hardcoded) | No (auto-detected at runtime) |
| Profile isolation | ✅ | ✅ |
| Extension presets | ✅ | ✅ (expanded) |
| Cloud gaming presets | ✅ | ✅ |
| App cloning | ✅ | ✅ |
| Auto icon download | ✅ | ✅ |
| Update banner | ✅ | ✅ |
| GTK4 / Adwaita UI | ✅ | ✅ |
| Dark mode | ✅ | ✅ |

---

## Community & Support

- **Discord:** https://discord.gg/7fEt5W7DPh
- **Patreon (Beta Builds):** https://www.patreon.com/c/BobbyComet/membership
- **Support the Griffin Project:** https://ko-fi.com/bobby60908
