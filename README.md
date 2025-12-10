<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Screenshot" width="25%"/>
</div>
# Appify – The Ultimate Linux PWA Manager

**Turn any website into a first-class desktop app — instantly.**

![Appify Screenshot](https://github.com/bobbycomet/Appify/blob/main/Appify1.png)

**VERSION 1.0.3 UPDATE: Fixed some issues where Firefox native was not launching in kiosk, you must use the system package of Firefox stable to have controller support, this is because Flatpak browser does not support it as well.**
**Brave browser now allows icons, but the Flatpak version does not. This is due to the sandboxing.**

**Appify** (formerly known as PWA Manager) is a beautiful, powerful, and powerful Progressive Web App (PWA) creator for Linux. Designed with **Windows switchers** in mind, it makes web apps feel native — complete with their own window, taskbar icon, isolated profiles, extensions, and performance controls.

Whether you're turning Gmail into a desktop app, running multiple Twitch accounts, or playing cloud games with anti-cheat bypasses — **Appify does it all**.

It will soon be available as:
- **AppImage** (Universal Linux)

> Built for **Griffin Linux** — soon to be available for everyone.

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
```
wget -O pwamanager.deb https://github.com/bobbycomet/Appify/releases/download/v1.0.2/pwamanager-1.0.2.deb
sudo dpkg -i pwamanager.deb 
sudo apt --fix-broken install -y 
rm pwamanager.deb
```
Coming soon
App image
Windows version

What is not coming
Flatpak
Why?
It would break many of the functions because of their sandboxing.

Discord- https://discord.gg/7fEt5W7DPh
