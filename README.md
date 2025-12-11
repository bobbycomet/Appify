<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Screenshot" width="25%"/>
</div>
# Appify – The Ultimate Linux PWA Manager

**Turn any website into a first-class desktop app — instantly.**

![Appify Screenshot](https://github.com/bobbycomet/Appify/blob/main/Appify1.png)

**VERSION 1.0.5 UPDATES: Presets now show in the extensions window, and fixed a minor bug that was not updating the config folder in the .pwa_manager folder. If you have issues with the config file not updating, you must delete the profile and reinstall the PWA you made.** 

**NEW ADDITIONs: More sites in the presets, and more extensions in the presets. Some Google Docs add-ons that are from Google, not the Chrome store.**

**Keeps the fixed issues where Brave native was not launching. Cleaned up the Brave logic for better Flatpak, snap, and native browser launching. Brave Browser now allows icons, but the Flatpak version does not. This is due to the sandboxing, not the tool.**

**Added tooltips, just hover over nice, ionice, GPU acceleration, and Kiok mode, and it will give you a rundown on what it does.**

**Added an about page, which has all the normal legal license stuff, but also has how to raise an issue with the tool, Discord, how to support the project, and so on.**

**You must use the system package of Firefox stable to have controller support; this is because the Flatpak browser does not support it out of the box. Again, a Flatpak sandboxing issue.**


**Appify** (formerly known as PWA Manager) is a beautiful, powerful, and free Progressive Web App (PWA) creator for Linux. Designed with **Windows switchers** in mind, it makes web apps feel native — complete with their own window, taskbar icon, isolated profiles, extensions, and performance controls.

Whether you're turning Gmail into a desktop app, running multiple Twitch accounts, or playing cloud games with anti-cheat bypasses — **Appify does it all**.


> Built for **Griffin Linux aka Griffin OS** — soon to be available for everyone.

---

### Why Appify?

| Feature                                 | Appify                          | Native Browser PWA | Edge/Chrome SSBs |
|---------------------------------------- |----------------------------------|---------------------|------------------|
| Isolated profiles (logins preserved)    | Yes                              | Yes                 | Yes              |
| Custom icons per app                    | Yes                              | Sometimes           | No               |
| Flatpak/Snap/Native browser support     | Yes                              | No                  | No               |
| GPU acceleration toggle                 | Yes                              | No                  | No               |
| nice/ionice tuning                      | Yes                              | No                  | No               |
| Kiosk mode (perfect for cloud gaming)   | Yes                              | Limited             | Limited          |
| Extension presets (Twitch, YouTube, etc.) | Yes                            | No                  | No               |
| Clone apps (multi-account support)      | Yes                              | No                  | No               |
| Search + 61 curated app presets         | Yes                              | No                  | No               |
| Works after uninstall (profile kept)    | Yes                              | No                  | No               |

---

### Key Features

#### Fully Isolated Profiles
Each PWA gets its own browser profile:
- Saved logins
- Cookies & site data
- Extensions
- Settings
- No data leaks to other profiles

**Uninstall an app? Your data stays safe.** Reinstall later — everything is still there.

**Light/Dark modes**

**Want to take the data with you?** Just copy your folder .pwamanager (should be in your home directory, just choose show hidden files), and you can place it in a new computer for your profiles and everything else to work. This is for safety. I could add an import/export, but this way, if something broke in the import/export, you lose data; it will not mess up your data by doing it this way.

#### Per-App Icons & Taskbar Identity
No more "another Chrome window" confusion.

- Twitch → Purple Twitch icon
- YouTube → Red YouTube icon
- Discord → Discord icon
- Even custom sites get smart icons (via icon.horse + favicon + Google fallbacks)

#### Cloud Gaming Ready
Dedicated kiosk presets for:
- Xbox Cloud Gaming (xCloud)
- GeForce Now
- Amazon Luna

Uses **Firefox Flatpak** by default for:
- Native gamepad support
- Better Wayland compatibility
- Anti-cheat workarounds (when needed)

V1.0.2 fixed the kiosk mode issue. All cloud gaming will launch in a console-like mode now.

#### Multi-Account Heaven
**Clone any app** in one click:
- Main + Alt Twitch accounts
- Work + Personal Gmail
- Two YouTube Music instances
- Two Discord logins

#### Streamer and Moderator heaven
- Copy the link of your streaming tools (chat, mod tools, events, etc.)
- Panel them how you want

All run simultaneously with isolated profiles.

#### Extension Presets (One-Click Setup)
Auto-open extension pages in the correct isolated profile:
- **Twitch**: BetterTTV, FrankerFaceZ, 7TV
- **Kick**: NipahTV, 7TV
- **YouTube**: SponsorBlock, uBlock Origin, Return YouTube Dislike

Or add **any extension** manually — just click "Open Store" and install (PWA must be installed for manual to work).

#### Full Browser Support
Works with:
- Native installs
- Flatpak (Firefox, Brave, Edge, etc.)
- Snap packages

Supports:
- Microsoft Edge (default, but you can swap it to your favorite)
- Brave · Vivaldi · Chrome · Firefox · Opera

#### Performance Controls
Fine-tune every PWA:
- GPU acceleration on/off
- `nice` priority (-20 to 19)
- `ionice` class (realtime, best-effort, idle)
- Already configured for most uses, so many of you will never need to touch this.

Perfect for gaming, streaming, or background apps.

#### Smart Desktop Integration
- Real `.desktop` files
- Proper WM_CLASS & DBus names
- Shows up in app menu
- Correct icon in dock/taskbar
- Works perfectly on GNOME, KDE, XFCE, etc.

#### Search + 61 Preconfigured Apps
Including:
- Gmail, Google Docs, Office 365
- Discord, Slack, Zoom
- Netflix, YouTube, Spotify, Twitch
- Notion, Trello, ClickUp
- Amazon, Reddit, X/Twitter
- Cloud gaming platforms
- And many more!

Just search, tweak, install.

Install
Download the Deb directly from the releases page or from the source. Here is how to set the environment.
```
wget -O pwamanager.deb https://github.com/bobbycomet/Appify/releases/download/v1.0.2/pwamanager-1.0.5.deb
sudo dpkg -i pwamanager.deb 
sudo apt --fix-broken install -y 
rm pwamanager.deb
```

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
chmod +x PWAmanager.py
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

Coming soon
More updates for tool tips, YouTube videos (not really needed, but some people understand better with visuals), and more PWA site presets.
Griffin Repo, as stated, this is for a custom distro I am almost finished with. This tool will be a part of that repo. This tool might get an update checker, ot I might turn it into its own repo for updates. Have yet to decide.
Windows version

What is not coming soon
Appimage
Why?
I tried it multiple times, but I can't seem to grasp how to make them. It might be a while before I have an AppImage. For now works on Debian/Ubuntu systems.
Flatpak
Why?
It would break many of the functions because of their sandboxing.

Discord- https://discord.gg/7fEt5W7DPh
