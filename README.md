<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Screenshot" width="25%"/>
</div>

# Appify – The Ultimate Linux PWA Manager

Turn any website into a first-class desktop application — instantly.

Appify creates isolated, native-feeling PWAs on Linux using your existing browser engines. No Electron overhead, no memory-hungry wrappers. Just clean, integrated desktop apps.

Appify is ideal for Windows switchers, streamers, multi-account users, and anyone who wants cloud gaming or productivity apps to behave like true native applications.

![Appify Screenshot](https://github.com/bobbycomet/Appify/blob/main/Extensionsview.png)


**VERSION 1.0.5 UPDATES: Presets now show in the extensions window, and fixed a minor bug that was not updating the config folder in the .pwa_manager folder. If you have issues with the config file not updating, you must delete the profile and reinstall the PWA you made.** 

**NEW ADDITIONS: More sites in the presets, and more extensions in the presets. Extensions show what is installed or available. Some Google Docs add-ons that are from Google, not the Chrome store.**

**Changed the Remove entry to Delete profile for clarity.**

**Keeps the fixed issues where Brave native was not launching. Cleaned up the Brave logic for better Flatpak, snap, and native browser launching. Brave Browser now allows icons, but the Flatpak version does not. This is due to the sandboxing, not the tool.**

**Added tooltips, just hover over nice, ionice, GPU acceleration, and Kiok mode, and it will give you a rundown on what it does.**

**Added an about page, which has all the normal legal license stuff, but also has how to raise an issue with the tool, Discord, how to support the project, and so on.**

**You must use the system package of Firefox stable to have controller support; this is because the Flatpak browser does not support it out of the box. Again, a Flatpak sandboxing issue.**


**Appify** is a beautiful, powerful, and free Progressive Web App (PWA) creator for Linux. Designed with **Windows switchers** in mind, it makes web apps feel native — complete with their own window, taskbar icon, isolated profiles, extensions, and performance controls. No electron eating your RAM here.

Whether you're turning Gmail into a desktop app, running multiple Twitch accounts, or playing cloud games with anti-cheat bypasses — **Appify does it all**.


## Key Features

- Isolated Profiles for Every App

- Each PWA gets its own sandboxed environment:

- Unique logins

- Separate cookies and site data

- Independent extensions & settings

- Uninstalling an app does not erase its data. Simply reinstall later and everything returns.

- You can nuke the entire pwa and profile with delete app and choosing delete profile.

### To back up or migrate profiles, copy the hidden directory:

```
~/.pwa_manager
```

- Smart Icons & Native Desktop Integration

- No more “another Chrome window.”

## Each PWA gets:

- Correct icon & branding (favicon → icon.horse → Google fallback)

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

- One-click extension bundles for:

- Twitch (BTTV, FFZ, 7TV)

- Kick (NipahTV, 7TV)

- YouTube (SponsorBlock, uBlock, Return YouTube Dislike)

- Google Docs add-ons (Google-native only)

- You can add as many as you want, and is not limited to just ome browser

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

- **1.0.6 is available early on Patreon for beta testers.**

## Install

Download the AppImage or Deb directly from the releases page or from the source.

AppImage, be sure to check your permissions that you set it to launch as an application.

```
wget https://github.com/bobbycomet/Appify/releases/download/v1.0.5.1/Appify-x86_64.AppImage
chmod +x Appify-x86_64.AppImage
```

**Deb download, you can use the wget method or download from the releases and use your distro's package installer or gdebi (best method to make sure dependencies are fulfilled)**

```
sudo apt update
sudo apt install gdebi
```
```
sudo gdebi Appify-1.0.5.deb
```
```
wget https://github.com/bobbycomet/Appify/releases/download/v1.0.5/Appify-1.0.5.deb
sudo dpkg -i pwamanager.deb 
sudo apt --fix-broken install -y 
rm Appify.deb
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

A Flatpak build would break core functionality due to sandbox restrictions, including:

Browser detection would break

Extension installation would break

Profile isolation would break

Wayland/X11 switching would break

Controller support would break

And more issues that flat seal would not be able to fix

Until these limitations can be resolved, a Flatpak package is not planned.

## Roadmap

<p align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/Griffin-G.png" alt="Griffin Screenshot" width="25%"/>
</p>

Coming soon:

Griffin Linux

Built-in update checker for deb an AppImage

Windows version


## Community & Support

Discord: https://discord.gg/7fEt5W7DPh

Patreon (Beta Builds): https://www.patreon.com/c/BobbyComet/membership

Support the Griffin Project: https://ko-fi.com/bobby60908
