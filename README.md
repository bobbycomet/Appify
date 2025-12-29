<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Screenshot" width="25%"/>
</div>

# Appify – The Ultimate Linux PWA Manager

**Version 1.0.5.2 is out in AppImage and deb file.**

Turn any website into a first-class desktop application — instantly.

Appify creates isolated, native-feeling PWAs on Linux using your existing browser engines. No Electron overhead, no memory-hungry wrappers. Just clean, integrated desktop apps.

Appify is ideal for Windows switchers, streamers, multi-account users, and anyone who wants cloud gaming or productivity apps to behave like true native applications.

![Appify Screenshot](https://github.com/bobbycomet/Appify/blob/main/Extensionsview.png)


**NIPAHTV EXTENSION ISSUE:** This is not caused by the tool, but what is happening is that when you tile Kick, NipahTV will not work properly. This has to do with an issue between Chromium browsers and being in app mode. This is only when tiled; otherwise, it is fine, and the extension will work.

**VERSION 1.0.5.2 UPDATES:**

**Bug fixes:**

**Fixed a bug that caused the extensions to open in Edge by default and sometimes provided incorrect links, replacing them with correct links for Chrome extensions.**

**Fixed a bug where attempting to add extensions one by one resulted in a URL error. You can now add or remove extensions individually.**

**Removed old links that no longer work for extensions.**

**Fixed the name, as I made a typo, where it said Applify, and not Appify.**

**New feature:**

**Added an update banner when a newer version is out.**

**Deb bug fix:**

Fixed where the app was not showing due to a messed-up exec=

**Firefox specific:**

**You must use the system package of Firefox stable to have controller support; this is because the Flatpak browser does not support it out of the box. Again, a Flatpak sandboxing issue.**

Whether you're turning Gmail into a desktop app, running multiple Twitch accounts, or playing cloud games with anti-cheat bypasses — **Appify does it all**.


## Key Features

- Isolated Profiles for Every App

- Each PWA gets its own sandboxed environment:

- Unique logins

- Separate cookies and site data

- Independent extensions & settings

- Uninstalling an app does not erase its data. Simply reinstall later and everything returns.

- You can nuke the entire PWA and profile with delete app and choosing delete profile.

### To back up or migrate profiles, copy the hidden directory:

- Smart Icons & Native Desktop Integration

- No more “another Chrome window.”

```
~/.pwa_manager
```

## Why Appify Stays Always Up-to-Date & Lightweight

Unlike Electron-based tools (e.g., Nativefier) that bundle an outdated Chromium engine, Appify uses your **existing system browser** as the engine.

- Each PWA is launched with an **isolated profile** (`--user-data-dir` for Chromium-based, `--profile` for Firefox).
- When you update your browser (Edge, Firefox, Chrome, Brave, etc. — via apt, dnf, Flatpak, or Snap), **every Appify PWA automatically gets the latest version**.
  - Instant security patches
  - New performance improvements
  - Latest web standards (e.g., better AV1 decoding, WebGPU)
  - Updated extension support
- No waiting for Appify updates to "refresh" the embedded browser.
- Extremely low overhead: Only per-app profiles are added (a few MB each), sharing the single browser engine.

This "pseudo-browser" approach keeps Appify secure, fast, and future-proof — while delivering a truly native feel.

| Aspect                  | Appify (System Browser Engine)                  | Electron Wrappers (e.g., Nativefier)           |
|-------------------------|-------------------------------------------------|------------------------------------------------|
| Browser Updates         | Automatic & immediate                           | Delayed (bundled old version)                  |
| Security Patches        | Always current                                  | Only when wrapper is rebuilt                   |
| Disk/Memory Usage       | Minimal (shared engine)                         | High (50–200+ MB per app)                      |
| Hardware Acceleration   | Full access to latest drivers/features          | Often outdated or broken                       |
| Gamepad/Wayland Support | Native (especially Firefox)                     | Frequently lags behind                         |

![pwa files Screenshot](https://github.com/bobbycomet/Appify/blob/main/appifyfiles.png)

![profiles Screenshot](https://github.com/bobbycomet/Appify/blob/main/appifyprofiles.png)

![profile innards files screenshot](https://github.com/bobbycomet/Appify/blob/main/appifyprofileinards.png)

![sh files screenshot](https://github.com/bobbycomet/Appify/blob/main/appify-shfiles.png)


## Each PWA gets:

- Correct icon & branding (favicon → icon.horse → Google fallback)
The image below has a theme installed; icons do not look like some of the others that are themed. I will try to get the icons to work with themes.

![sh files screenshot](https://github.com/bobbycomet/Appify/blob/main/Icons.png)

- Proper .desktop file

- Correct WM_CLASS and D-Bus names

- Full integration with GNOME, KDE, XFCE, etc.

## Cloud Gaming Ready:

- Console-style kiosk presets for:

- Xbox Cloud Gaming (xCloud)

- GeForce Now

- Amazon Luna

## Use Firefox stable version by default for:

- Native gamepad support

- Better Wayland behavior

- Certain anti-cheat workarounds

- Multi-Account Made Simple

## Clone any app instantly:

- Multiple Twitch accounts

- Personal + Work Gmail

- Streaming dashboards

- Multiple Discord or YouTube logins

- Each clone runs in its own isolated environment.

## Extension Presets:

**One-click extension bundles for:**

- Twitch (BTTV, FFZ, 7TV)

- Kick (NipahTV, 7TV)

- YouTube (SponsorBlock, uBlock, Return YouTube Dislike)

- Google Docs add-ons (Google-native only)

- You can add as many as you want, and it is not limited to just one browser

- You can also install any Chrome-compatible extension manually inside each isolated profile.

## Complete Browser Support:

- Native browser installations

- Flatpak

- Snap

## Supported browsers:

- Microsoft Edge (default)

- Brave

- Vivaldi

- Chrome/Chromium

- Firefox

- Opera

## Performance Controls (Advanced)

- Every PWA can be tuned individually:

- Toggle GPU acceleration

- Set CPU priority (nice)

- Set I/O priority (ionice)

- Defaults are optimized for mainstream usage, but power users can fine-tune cloud gaming, streaming, or background apps.

## Wayland & X11 Support

- Appify detects your environment automatically.

- **Version 1.0.6 introduces stricter Wayland/X11 detection, but due to minor delays on startup, 1.0.5 remains the stable release, and still supports Wayland. Wayland being the thing to replace X11, I am only preparing the app for that, but Wayland is still not fully reliable for everything, just yet.**

- **1.0.6 is available early on Patreon for beta testers. Check the bottom of the page.**

## Install

Download the AppImage or Deb directly from the releases page or from the source.

AppImage, be sure to check your permissions so that you set it launches as an application.

```
wget https://github.com/bobbycomet/Appify/releases/download/v1.0.5.2/Appify-x86_64.AppImage
chmod +x Appify-x86_64.AppImage
```

**Deb download, you can use the wget method or download from the releases and use your distro's package installer or gdebi (best method to make sure dependencies are fulfilled)**

```
sudo apt update
sudo apt install gdebi
```
```
sudo gdebi Appify-1.0.5.2.deb
```
```
wget https://github.com/bobbycomet/Appify/releases/download/v1.0.5/Appify-1.0.5.2.deb
sudo dpkg -i Appify-1.0.5.2.deb
sudo apt --fix-broken install -y 
rm Appify-1.0.5.2.deb
```

**If you use it from source, here is how to build the environment.**

For Fedora, CentOS, RHEL, etc...
```
sudo dnf install python3-gobject gtk4 libadwaita curl xdg-utils
```
For Arch, Manjaro, etc... 
```
sudo pacman -S python-gobject gtk4 libadwaita curl xdg-utils
```
For OpenSUSE, Tumbleweed, etc...
```
sudo zypper install python3-gobject typelib-1_0-Gtk-4_0 typelib-1_0-Adw-1 curl xdg-utils
```
Debian/Ubuntu
```
sudo apt update
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-4.0 gir1.2-adw-1 curl xdg-utils
```
Don't forget to (the py file name will update in the future)
```
chmod +x Appify.py
```
For the desktop file (use the icon in the files above)
```
[Desktop Entry]
Version=1.0
Type=Application
Name=PWA Manager (Appify)
Comment=Manage and launch isolated Progressive Web Apps
Exec=pwamanager
Icon=appify
Terminal=false
Categories=Utility;Network;
StartupNotify=true
```

## Why No Flatpak Version?

- A Flatpak build would break core functionality due to sandbox restrictions, including:

- Browser detection would break

- Extension installation would break

- Profile isolation would break

- Wayland/X11 switching would break

- Controller support would break

- And more issues that flat seal would not be able to fix

Until these limitations can be resolved, a Flatpak package is not planned.

## Roadmap

<p align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/Griffin-G.png" alt="Griffin Screenshot" width="25%"/>
</p>

**Coming soon:**

- Griffin Linux

- Windows version


## Community & Support

Discord: https://discord.gg/7fEt5W7DPh

Patreon (Beta Builds): https://www.patreon.com/c/BobbyComet/membership

Support the Griffin Project: https://ko-fi.com/bobby60908
