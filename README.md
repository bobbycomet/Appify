<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

Version 2.0.2 bug fix. Removed dead-linked extensions, fixed Google extension logic, before Google Docs extensions were showing up under Google Sheets and Google Slides. Now they appear under the proper PWA to be made; this was because of how the links were set up. All three have the hostname docs.google.com. The fix: the more-specific path-based entries need to be checked before the hostname-only docs.google.com entry. The solution was to reorder PRESET_DOMAIN_MAP so path-based keys come first, OR better yet, update get_app_key to check path-based keys first.

It now has multilingual support. It checks for your .mo file and on their system, and then uses a process to apply the system language and translates; if that fails, it then reverts to English.

2.0.1 Fixed a bug where installing a custom PWA was trying to install the PWA in your list rather than adding a link. I fixed a bug where WebHID wasn't activating, and Xcloud is still not working with WebHID. For better controller support on Xcloud, please use Firefox. I tried using Better Xcloud, but no luck. Your mileage may vary.

# Appify 2.0 – Why It's a Major Upgrade Over 1.x

Appify 2.0 is not just a bug fix release — it's a ground-up rethinking of how Appify detects, manages, and launches browsers. This page explains exactly what changed, what's new, and what stayed the same so you can decide whether to upgrade.

Read the wiki for how Appify handles the update to browser settings.

https://github.com/bobbycomet/Appify/wiki#overview
---

## What's New in 2.0

### Intelligent Browser Detection

The biggest change in 2.0 is how Appify finds and uses browsers. In 1.x, browser commands were hardcoded strings in the config — for example, Firefox was always `env GDK_BACKEND=x11 /usr/bin/firefox` and Edge was always `microsoft-edge`. If your browser was installed differently, things could break silently.

In 2.0, Appify runs a real detection system at startup. For every browser, it checks:

1. **Native installation** — searches your `PATH` and known binary locations
2. **Flatpak** — queries `flatpak info` to confirm the app is installed
3. **Snap** — queries `snap list` to confirm the app is installed

The result is that Appify now shows you only the browsers actually present on your system, tells you *how* each one is installed (native, Flatpak, or Snap), and generates the correct launch command automatically. No more editing configs or wondering why Edge won't open.

<div align="center">
  <img src="https://github.com/bobbycomet/Appify/blob/main/Appify2.0.png">
</div>

### Default Browser Auto-Detection

In 1.x, the default browser was hardcoded to Edge regardless of what you had set on your system. In 2.0, Appify reads your actual system default using `xdg-settings`, `mimeapps.list`, and the `gio` tool as fallbacks. When you install a new PWA without manually picking a browser, Appify uses the browser your system already considers the default.

### True Wayland/X11 Detection and Optimization

In 1.x, the Wayland/X11 situation was a known rough edge — Firefox was forced to launch with `GDK_BACKEND=x11` regardless of whether you were actually running X11 or Wayland. Chromium-based browsers used `--ozone-platform-hint=auto` as a guess.

In 2.0, Appify detects your session type by checking `$WAYLAND_DISPLAY` and `$DISPLAY` environment variables, then applies the correct flags per-browser:

- On **Wayland**, Chromium-based browsers get `--ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations`
- On **X11**, no extra flags are needed and none are added
- On unknown sessions, `--ozone-platform-hint=auto` is used as a safe fallback
- Firefox on Wayland no longer gets forced to X11

Each generated launcher script also embeds a comment showing the detected session type and browser installation type, making debugging far easier.

### Expanded Browser Support (Now 8 Browsers)

1.x supported Firefox, Edge, Brave, and Vivaldi in its config — Chrome and Chromium existed as entries but weren't reliably configured. Opera was listed as supported in the readme but absent from the default config.

2.0 fully supports all **8 browsers** with complete detection, correct launch arguments, extension store URLs, and Wayland flags:

| Browser | Native | Flatpak | Snap |
|---|---|---|---|
| Firefox | ✅ | ✅ | ✅ |
| Microsoft Edge | ✅ | ✅ | ✅ |
| Brave | ✅ | ✅ | ✅ |
| Vivaldi | ✅ | ✅ | ✅ |
| Google Chrome | ✅ | ✅ | ✅ |
| Chromium | ✅ | ✅ | ✅ |
| Opera | ✅ | ✅ | ✅ |
| Ungoogled Chromium | ✅ | — | — |

### Enhanced WebHID and Gamepad Support

1.x added basic WebHID support as an enhancement in its final release. 2.0 expands this into a full set of flags for cloud gaming on Chromium-based browsers:

```
--enable-features=WebHID
--enable-gamepad-button-axis-events
--disable-features=WebHidBlocklist
```

These flags are applied alongside the correct Wayland or X11 display backend flags, rather than separately, so cloud gaming apps receive the full stack of optimizations in a single launch.

### Browser Selection No Longer Defaults Everything to Edge

In 1.x, every preset app in the default list had `"browser": "edge"` hardcoded into its entry. This meant that even if Edge wasn't installed, new installs would attempt to use it. In 2.0, the default browser field is `null` and resolved at runtime by the detection system, so you always get a browser that's actually on your machine.

### Smarter Launcher Scripts

The `.sh` launcher scripts that Appify generates for each PWA are improved in 2.0. They now include:

- A comment header showing the detected session type and browser display name
- Correct `setsid` wrapping to fully detach from the terminal
- `set -euo pipefail` and `set -x` for cleaner error handling and logging
- Session-type-aware GDK backend for Firefox kiosk mode (X11 vs Wayland)

---

## What's Improved in 2.0

### No More Hardcoded `GDK_BACKEND=x11` for Firefox

In 1.x, Firefox always launched with `env GDK_BACKEND=x11 /usr/bin/firefox` baked into the config. This caused issues on pure Wayland sessions. In 2.0, the GDK backend is only set for kiosk mode when you're actually on X11, and is left unset on Wayland so Firefox handles the session natively.

### Extension Preset Expansion for YouTube

1.x had 3 YouTube extensions (SponsorBlock, uBlock Origin, Return YouTube Dislike). 2.0 adds 4 more: Unhook for YouTube, Enhancer for YouTube, DeArrow, and YouTube NonStop.

### AI Apps Added to Preset List

2.0 adds a dedicated AI & Search category to the preset app list with entries for ChatGPT, Claude, Grok, Gemini, and Perplexity — none of which were in 1.x.

### Streamlabs Dashboard Added

2.0 adds a separate "Streamlabs Dashboard" entry alongside the existing Streamlabs OBS Web preset, useful for streamers who want quick access to their dashboard separately from the full OBS interface.

### Config Structure Modernized

In 1.x, the config stored `"browser": "edge"` as a fixed string at the top level. In 2.0, the config stores `"browser": null` (auto-detected at launch) plus a new `"available_browsers"` dict and `"session_type"` field that are populated on first run. Existing 1.x configs continue to work through the migration system that was already in place.

---

## What Stayed the Same

Everything that made Appify useful in 1.x is still here and unchanged in 2.0:

- **Isolated profiles** — every PWA gets its own `~/.pwa_manager/profiles/<slug>/` directory with separate cookies, logins, and extensions
- **Profile data is preserved on uninstall** — reinstalling a PWA brings back all your data; choosing "Delete Profile" is the only way to wipe it
- **The GTK4/Adwaita UI** — same dark mode, same layout, same app combo, kiosk toggle, GPU toggle, nice/ionice spinners
- **Extension presets** — Twitch (BTTV, FFZ, 7TV), Kick (NipahTV, 7TV), YouTube, Google Docs/Sheets/Slides, Reddit, Discord, Netflix, and many more
- **Custom PWA installation** — paste any URL and give it a name
- **App cloning** — duplicate any PWA with its own isolated profile
- **Cloud gaming presets** — Xbox Cloud Gaming, GeForce NOW, Amazon Luna, Boosteroid, AirGPU with kiosk mode and Firefox-first recommendations
- **Auto icon download** — icon.horse → Google favicons → direct favicon.ico fallback chain
- **Correct `.desktop` files** — `StartupWMClass`, `X-DBus-Name`, `TryExec`, and proper category flags
- **Update banner** — checks GitHub Releases on launch and notifies you of newer versions (skips pre-releases)
- **Full logging** — all launches write to `~/.pwa_manager/launch.log`
- **No Flatpak version of Appify itself** — sandboxing still breaks browser detection, extension installation, profile isolation, Wayland/X11 switching, and controller support

---

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
wget https://github.com/bobbycomet/Appify/releases/download/v2.0.0/Appify-2.0.0-x86_64.AppImage
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
wget https://github.com/bobbycomet/Appify/releases/download/v2.0.0/Appify-2.0.0.deb
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
