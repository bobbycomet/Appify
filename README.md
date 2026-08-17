<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/appify.png" alt="Appify Logo" width="25%"/>
</div>

<div align="center">

# Appify

**Three clicks to install apps from the catalog.**

Appify is a Linux web-app manager that lets you pick from a catalog of **175+ popular services**, choose the browser you already use, and turn the service into an isolated desktop app in three clicks, with deep customization available when you want it.

**Appify 3.0 is here:** a full PyQt6 rewrite, the Griffin Dark Theme, and a much deeper set of management and customization options.

[![Latest Release](https://img.shields.io/badge/release-v3.0.3-blue)](https://github.com/bobbycomet/Appify/releases/tag/v3.0.3)
[![Part of Griffin Linux](https://img.shields.io/badge/project-Griffin%20Linux-purple)](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/)

[Video Showcase](https://youtu.be/Ql2JzdyAA6M?si=vyLsMP9mZxMolYvI) | [Full Comparison Table](https://bobbycomet.github.io/Appify/) | [Discord](https://discord.gg/7fEt5W7DPh)

</div>

---

# Why Appify Is Different

Linux is an excellent desktop operating system, but web applications have traditionally been awkward to integrate into the desktop. The usual solutions involve tradeoffs.

Chromium-based browsers have built-in "Install App" or "Create Shortcut" functionality, but those applications can remain closely tied to the browser's main profile. Firefox doesn't provide the same built-in workflow. Other tools can create web applications, but may require extra runtimes, terminal commands, manual configuration, browser-specific setup, fragile CSS hacks, separate browser engines, or Electron-based wrappers.

Appify takes a different approach: **use the browser you already have.**

Appify creates a dedicated browser profile for each application and manages the desktop integration around it. You don't need to manually create configuration files, write shell scripts, create `.desktop` entries, or figure out the appropriate browser flags — Appify handles those things automatically.

Appify is part of the larger [Griffin Linux project](https://bobbycomet.github.io/Griffin-Linux-Landing-Page/).

### Appify vs. Other Web-App Methods

| Method                             | Steps Involved                                             | Isolation     | Customization | Average Time                                                                     | Notes                                                          |
| :--------------------------------- | :--------------------------------------------------------- | :------------ | :------------ | :--------------------------------------------------------------------------------- | :--------------------------------------------------------------- |
| **Appify**                         | Open Appify → find app → choose browser → Install          | **Excellent** | **High**      | **14.05 seconds** from opening Appify to opening an app with no advanced options | Three-click workflow with optional power-user features         |
| **Linux Mint Webapp Manager**      | Open Webapp Manager → paste URL → choose browser → Install | Limited       | Low            | 60–90 seconds                                                                     | Good basic experience, but less flexible outside Mint/Cinnamon |
| **Browser Built-in "Install App"** | Open browser → navigate to site → Menu → Install            | Poor          | None           | 60–90 seconds                                                                     | Quick, but generally shares the browser's main profile          |
| **Nativefier / CLI Tools**         | Install dependencies → run commands → configure flags       | **Excellent** | **Very High**  | 2–5+ minutes                                                                       | Powerful, but manual and heavier                                |

Appify's goal isn't to expose every option during installation. The normal path is intentionally simple:

> **Find → Browser → Install**

The advanced system is there when you need it, not because everyone needs to use it.

---

## Screenshots

<div align="center">

| | |
|:---:|:---:|
| <img width="960" alt="Screenshot_20260414_022537" src="https://github.com/user-attachments/assets/3ad375f1-d641-40df-b83f-d1fd275cd8db" /> | <img width="960" alt="Screenshot_20260703_053801" src="https://github.com/user-attachments/assets/23d0d519-ec0d-430b-9336-394a3c381050" /> |
| <img width="960" alt="Screenshot_20260703_053734" src="https://github.com/user-attachments/assets/07ca8ff9-aa12-4e9b-aa77-919edcb68b3e" /> | <img width="960" alt="Screenshot_20260703_053655" src="https://github.com/user-attachments/assets/97180002-d23a-4246-8d4b-626e52162b8f" /> |
| <img width="960" alt="Screenshot_20260702_113739" src="https://github.com/user-attachments/assets/6577058f-104e-47e9-8c63-7765b9aef02f" /> | <img width="960" alt="Firefox userChrome.css / userContent.css example" src="https://github.com/user-attachments/assets/5e297340-169f-4eb3-9d11-eed70fe2ffe1" /> |

*Bottom-right: a Firefox `userChrome.css` / `userContent.css` example.*

</div>

---

# How It Works

The basic workflow is intentionally simple — **three clicks** from open to installed.

### 1. Find an app

Search by name, browse by category, or choose from the 175+ built-in applications.

### 2. Choose your browser

Appify automatically detects supported browsers installed on your system. Use your default browser or choose another one. Native installations, Flatpaks, and Snaps are detected automatically.

### 3. Install

Click **Install**. Appify then:

1. Creates the application's isolated profile
2. Configures the browser
3. Generates its launcher wrapper
4. Creates the `.desktop` entry
5. Installs the application icon
6. Stores the application's metadata

Typical installation time is **under one second**. There is no loading bar because there generally isn't anything to wait for.

Once installed, the app can be launched directly from Appify or from your normal desktop application launcher.

---

## 175+ Sites Ready to Install

Appify includes a data-driven catalog of more than **175 popular web applications and services**.

Browse by category or search by name. The catalog covers a wide range of uses, including:

* AI & Search
* Productivity
* Google Workspace
* Microsoft tools
* Communication
* Social media
* Streaming
* Streaming tools
* Cloud gaming
* Video editing
* Image editing
* Art & Design
* Shopping
* Utilities
* News & Knowledge

You can also add your own sites when something isn't already in the catalog.

The goal is simple: **you shouldn't have to think about how to make a web app. You should only have to decide which web app you want.**

---

# Optional Features

The basic workflow is deliberately minimal. If you want more control, Appify provides it.

From the **☰ Menu** and **Advanced Options**, you can access features including:

* Custom browser selection
* Custom app icons
* Browser extension presets
* Custom extensions
* Kiosk mode
* GPU acceleration options
* Gamepad/WebHID support
* Process priority
* I/O priority
* Custom Firefox CSS
* Backup and restore
* Bulk installation
* Bulk backup
* Wrapper regeneration
* Data export/import
* Appify self-updates

These features are optional. You don't need to configure them to install a normal web app.

---

# Why 3.0?

Appify was originally launched in August 2025 using GTK4 and libadwaita.

That was a good stack if you were primarily targeting GNOME, but Appify is intended for the broader Linux desktop. Griffin Linux also uses KDE Plasma, while many other users run Cinnamon, XFCE, COSMIC, Sway, Hyprland, and other environments. The original version worked, but it was never completely at home outside the GNOME ecosystem.

**3.0 is a full rewrite of the interface using PyQt6.**

The underlying Appify architecture did not need to be thrown away. The isolated profile-per-app model, browser detection, installation system, generated wrappers, and browser-specific handling remain.

Instead, 3.0 rebuilds the interface around the **Griffin Dark Theme** used throughout the Griffin toolset, while removing the GNOME-shaped dependency and styling assumptions.

While the interface was being rebuilt, 3.0 also added several features users had been asking for.

### 3.0 Highlights

* **Custom app icons** — choose your own PNG, JPEG, GIF, BMP, ICO, or SVG icon
* **App sorting** — sort by Name, Category, Recently Used, or Installed First
* **Bulk installation** — install an entire category at once
* **Bulk backups** — back up the entire installed library in one operation
* **Self-updating through Griffin Updater** — check for Appify updates manually or automatically
* **One-click launching** — launch installed apps directly from Appify
* **Data-driven app catalog** — new catalog entries can be added through `store.json` without waiting for an Appify release
* **Firefox CSS support** — optionally apply `userChrome.css` and `userContent.css`
* **Expanded browser-family support** — including Brave variants and Firefox Beta/Nightly/Dev/ESR

Everything that worked in 2.x continues to work in 3.x. **This is a rebuild of the surface, not the foundation.**

### What's New in 3.0

| Feature                     | Before 3.0                                      | After 3.0                                                                         |
| ---------------------------- | ------------------------------------------------ | ------------------------------------------------------------------------------------ |
| **Interface**                | GTK4 + libadwaita                                | Full PyQt6 rewrite, styled as the Griffin Dark Theme                               |
| **Advanced options**         | Flat list of checkboxes                          | Collapsible **Advanced Options** panel with hover tooltips explaining each option  |
| **App icons**                | Auto-downloaded favicon only                     | Browse for PNG/JPEG/GIF/BMP/ICO/SVG icons or reset to automatic                    |
| **Finding apps**             | Search or browse                                 | Search, browse by category, and sort                                               |
| **Sorting**                  | Not available                                    | Name, Category, Recently Used, Installed First                                     |
| **Installing several apps**  | One at a time                                    | **Install All in Category**                                                        |
| **Backups**                  | One app at a time                                | **Backup All Installed Apps**                                                      |
| **Appify updates**           | Check GitHub manually                            | Check now, one-click update, or automatic scheduled checks                         |
| **Testing apps**             | Reopen through the desktop launcher              | **Launch** directly from Appify                                                    |
| **App catalog**              | Built into the application                       | Data-driven `store.json`                                                           |
| **Firefox extension store**  | Could falsely report Firefox as already running  | Reliably opens the existing Firefox window or starts a new one                     |
| **Firefox appearance**       | Not supported                                    | Optional `userChrome.css` / `userContent.css` support                              |
| **Browser support**          | Existing browser families                        | Expanded Brave and Firefox family support                                          |

### Known Issues in 3.0

* Xbox Cloud Gaming has a third-party gamepad limitation in Chromium-based browsers. This is upstream behavior from Xbox Cloud Gaming itself and is not something Appify can currently work around. See the Cloud Gaming section below for more information.

---

# Browser Support

Appify is designed around the browsers users already have installed. It can detect supported browser installations in native, Flatpak, and Snap formats.

### Chromium Family

Appify supports Chromium-based browsers, including:

* Chrome
* Chromium
* Microsoft Edge
* Brave
* Brave Beta
* Brave Nightly
* Brave Origin and its release/beta/nightly variants

Brave Origin support uses command detection rather than relying only on the browser's internal identity. If you migrated from Brave to Brave Origin, Appify can detect the correct command even though the browser's internal identity remains `brave-browser`.

### Firefox Family

Firefox support includes:

* Firefox
* Firefox Beta
* Firefox Nightly
* Firefox Developer Edition
* Firefox ESR

Firefox also receives the expanded browser-family handling used by Appify's wrapper system.

---

# 3.0.3 Browser Fixes

A recent Chromium browser update introduced a Linux input-method regression that could cause text fields inside Appified Chromium applications to display a blinking caret while refusing to accept keyboard input.

Appify 3.0.3 addresses this by regenerating Chromium wrappers with the appropriate X11 input-method configuration.

The same browser update also caused endless YouTube buffering when the **Return YouTube Dislike** extension was installed. Appify's wrapper regeneration handles this as well.

### After upgrading

Open **☰ Menu → Regenerate All Wrappers**.

This regenerates the existing application launchers with the updated browser handling. You do **not** need to reinstall every Appified application.

---

# Firefox `userChrome.css` and `userContent.css`

Firefox CSS customization is completely optional. Appify does **not** require `userChrome.css` to create Firefox web apps.

By default, Appify creates an isolated Firefox profile and generates a `user.js` containing the preferences necessary for a dedicated web-app environment. That includes:

* Suppressing first-run UI
* Disabling startup telemetry prompts
* Suppressing sync prompts
* Suppressing new-tab content
* Setting the homepage to the application's URL

Your normal Firefox profile remains separate.

## Optional CSS Support

If you want to customize the Firefox interface, Appify 3.0 allows you to paste raw `userChrome.css` and `userContent.css` into the Firefox Advanced Options panel.

The workflow is:

1. Browse [firefoxcss-store.github.io](https://firefoxcss-store.github.io/) for a layout.
2. Copy the raw `userChrome.css`.
3. Paste it into Appify's `userChrome.css` field.
4. Repeat with `userContent.css` if the layout provides one.
5. Appify writes the files into that application's Firefox profile automatically.

Appify also enables `toolkit.legacyUserProfileCustomizations.stylesheets` automatically, so there is no need to manually edit `about:config`.

### Important limitation

**Only CSS-only layouts are supported.**

Some layouts on firefoxcss-store also contain `.js` files for additional behavior. Appify only applies `userChrome.css` and `userContent.css`. Layouts requiring JavaScript will therefore not be fully functional through Appify.

Two test files are included in the repository:

* [`userChrome.css`](https://github.com/bobbycomet/Appify/blob/main/userChrome.css)
* [`userContent.css`](https://github.com/bobbycomet/Appify/blob/main/userContent.css)

These are included only as working examples for testing the feature. They are **not official Griffin Linux/Appify styling**.

Because Firefox's internal UI can change between releases, CSS layouts may require updates after future Firefox releases. Appify provides this feature as an optional capability and does not promise compatibility with specific third-party layouts.

---

# Cloud Gaming and Kiosk Mode

Appify includes kiosk mode specifically for web-based gaming.

When a cloud gaming application such as Xbox Cloud Gaming, GeForce NOW, or Amazon Luna is installed with kiosk mode enabled, it launches as a dedicated full-screen window without browser tabs, address bar, or browser chrome. The result behaves much more like a native game launcher.

## Why Firefox is the Default for Cloud Gaming

Firefox is the recommended browser for most cloud gaming services because it provides native gamepad support without requiring additional browser flags.

Chromium-based browsers such as Chrome, Edge, and Brave require WebHID-related configuration for gamepad access. Appify handles those flags automatically.

On Linux, however, WebHID device permission dialogs also depend on the `xdg-desktop-portal` daemon and an appropriate desktop-environment backend being available. If the portal stack is not configured correctly, a controller may simply be ignored without an obvious error.

## Xbox Cloud Gaming

Xbox Cloud Gaming is the exception.

Appify provides Chromium defaults for Xbox Cloud Gaming with the necessary WebHID flags already configured. Appify also checks whether the portal stack is available and warns you in the interface when it is not.

However, **third-party, non-Xbox-branded gamepads can still have problems with Xbox Cloud Gaming under Chromium.** This is a limitation of Xbox Cloud Gaming's Chromium support rather than an Appify limitation. Appify was also tested with Better Xcloud, but it did not resolve the underlying issue.

## Other Cloud Gaming Services

Appify defaults the following services to Firefox for the most reliable out-of-the-box controller experience:

* GeForce NOW
* Amazon Luna
* Boosteroid
* AirGPU

These services can also work with Chromium-based browsers, but Xbox Cloud Gaming tends to require more browser and portal-specific handling.

---

# App Management

Appify isn't only an installer. Once applications are installed, the manager keeps track of them and provides tools for managing the entire collection.

## Launch

The **Launch** button allows you to open any installed app directly from Appify. This is useful for testing an installation or simply managing your applications without leaving Appify.

## Sorting

Installed applications can be sorted by:

* Name
* Category
* Recently Used
* Installed First

## Bulk Installation

**Install All in Category** installs every application in a selected category that isn't already installed. This is useful if, for example, you want an entire collection of productivity, streaming, or creative applications without installing each one individually.

## Bulk Backups

**Backup All Installed Apps** backs up the entire Appify library in one operation.

---

# Backups and Restore

Every installed application can be backed up from its **Backup Manager**.

You can create:

* Individual application backups
* A complete backup of all installed applications

Backups are stored as `.tar.gz` archives. Each backup contains the entire browser profile, launcher, desktop file, application icon, and metadata sidecar.

Backups are stored at:

```text
~/.appify/.backup/<app-slug>/
```

Backups are timestamped so multiple restore points can be retained. Appify automatically keeps up to **10 backups per application**. When the limit is exceeded, the oldest backup is removed.

## Restore

Restoring a backup:

1. Removes the current profile
2. Restores the backed-up profile
3. Regenerates the launcher
4. Regenerates the desktop file
5. Uses the current system paths and environment

This means backups can be restored cleanly even when system paths or browser configurations have changed.

### Browser Extension Limitation

Before creating a backup, any extensions added to that application's browser profile must be removed. This is a browser limitation rather than an Appify limitation. Browser extensions store files inside the profile in ways that can result in inconsistent archive states when they are present during backup. Remove the extensions, create the backup, and reinstall them afterward if necessary.

Backups can also be moved to another computer by placing them in the appropriate backup directory. Appify will detect them there.

---

# Appify Self-Update

Appify can update itself without requiring you to manually download every release.

At startup, Appify checks the GitHub Releases API in a background thread and displays a notification when a newer stable release is available.

Open **☰ Menu → Update Settings…**. From there you can:

* Check for updates immediately
* Download and install updates with one click
* Configure automatic update checks
* Choose hourly, daily, weekly, or custom schedules

The updater supports both `.deb` and AppImage.

For scheduled updates, Appify can create:

* `appify-updater.sh`
* `appify-updater.service`
* `appify-updater.timer`

These are installed to:

```text
/usr/local/bin
/etc/systemd/system
```

A single `pkexec` prompt is used to authorize the system-level installation. The schedule can be selected from the interface, including a custom `OnCalendar` expression. No manual systemd file editing is required.

---

# Data-Driven App Catalog

The built-in application catalog is stored in `store.json`. This means catalog entries are data rather than hard-coded application logic.

New default applications can therefore be added to the catalog without requiring an Appify release simply to add another website.

The catalog currently contains **175+ applications** spanning the categories listed above. Users can still add custom sites when the application they want isn't in the catalog.

---

# Downloading and Installing

**Latest version: 3.0.3**

## Debian / Ubuntu / Linux Mint / Pop!_OS and Other Debian-Based Distros

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v3.0.3/appify_3.0.3.deb
sudo dpkg -i appify_3.0.3.deb
sudo apt-get install -f
```

You can also open the `.deb` file directly with your software manager. GDebi is also a good option.

## Other Distros and Portable Use

For Arch, Fedora, openSUSE, NixOS, and other distributions, use the AppImage:

```bash
wget https://github.com/bobbycomet/Appify/releases/download/v3.0.3/Appify-3.0.3-x86_64.AppImage
```

Then:

```bash
chmod +x Appify-3.0.3-x86_64.AppImage
./Appify-3.0.3-x86_64.AppImage
```

The AppImage can be moved anywhere and run directly. No installation is required.

Once Appify is running, you can also use **☰ Menu → Update Settings…** to check for future updates or configure automatic update checks.

For AppImages, Appify updates the file in place at its original location. For `.deb` installations, updates are handled through `apt`.

---

# Supported Distros

Appify is tested and known to work on:

### Debian-Based

* Ubuntu
* Linux Mint
* Pop!_OS
* Zorin OS
* elementary OS
* Debian

### RPM-Based

* Fedora
* openSUSE
* Nobara

Use the AppImage where appropriate.

### Arch-Based

* Arch Linux
* Manjaro
* EndeavourOS

Use the AppImage where appropriate.

### Independent

* NixOS
* Void Linux
* Most other modern systemd-based distributions

Use the AppImage where appropriate.

## Requirements

Appify requires:

* Python 3.10 or later
* PyQt6
* systemd

The `.deb` package includes the required Python/PyQt6 dependencies. The AppImage bundles its dependencies.

For manual installations on other distributions, the equivalent package is typically:

```text
python3-pyqt6
```

### systemd Requirement

**Appify requires a systemd-based operating system.** This is required for Appify's system-level updater functionality.

---

# Wayland and X11

Appify supports both Wayland and X11. The application automatically detects the current session and configures browser launch flags accordingly.

Appify also handles compositor-specific requirements for environments including:

* KDE Plasma
* GNOME
* Hyprland
* Sway
* COSMIC
* Other Wayland environments

The goal is that users do not have to manually determine which browser flags are appropriate for their current session.

If the session changes later, Appify can regenerate all application wrappers instead of requiring every application to be reinstalled.

---

# Firefox Profiles

Each Firefox application receives its own isolated profile. Appify automatically generates a `user.js` file containing the preferences required for the application.

The generated configuration suppresses:

* First-run UI
* Startup telemetry prompts
* Sync prompts
* New-tab content

It also sets the application's URL as the homepage.

The `user.js` file is rewritten on every install so that new preferences introduced by future Appify versions can automatically be applied to existing profiles.

If you want to add your own Firefox preferences, use:

```text
user-overrides.js
```

in the same profile directory instead of editing the generated `user.js` directly.

---

# Custom Icons

Appify can automatically download an application's favicon, but 3.0 also allows you to choose your own icon.

Supported formats include:

* PNG
* JPEG
* GIF
* BMP
* ICO
* SVG

When a custom icon is selected, Appify stores it in the application's icon slot and sets the `custom_icon` flag in `profile.json`. This prevents future reinstalls from silently replacing the custom icon with an automatically downloaded favicon.

Selecting **Reset to Auto** removes the custom icon setting and allows Appify to download the favicon again.

---

# Technical Details

Appify stores its configuration and application profiles in:

```text
~/.appify/
```

Older versions used:

```text
~/.pwa_manager/
```

Appify provides a guided migration from the old directory. The directory structure looks like this:

```text
~/.appify/
  config.json              # Global settings and app registry
  profiles/<app-slug>/     # Isolated browser profile per app
    user.js                # Firefox: auto-generated profile preferences
    profile.json           # Per-app metadata:
                           # browser, browser_type, gamepad,
                           # nice/ionice, custom_icon,
                           # last_launched timestamp
    installed.marker       # Presence flag used by list_installed_apps()
  scripts/                 # Generated launcher shell wrappers
  .backup/<app-slug>/      # Timestamped .tar.gz backup archives
```

---

# Launcher Wrappers

Each installed application receives a shell wrapper in:

```text
~/.appify/scripts/
```

The wrapper handles application-specific launch configuration, including:

* Nice process priority
* I/O priority
* GPU acceleration flags
* WebHID flags
* Wayland flags
* X11 flags
* Browser-specific launch behavior

A `.desktop` file is written to:

```text
~/.local/share/applications/
```

so the application appears in the normal desktop application launcher.

Application icons are stored at:

```text
~/.local/share/icons/hicolor/512x512/apps/
```

---

# Browser Detection

Appify checks for supported browsers in the following order:

1. Native installation
2. Flatpak
3. Snap

Browser detection is command-based where necessary so that browser variants can be distinguished correctly. This is particularly important for Brave Origin, where the internal browser identity remains `brave-browser` even when the installed executable command differs.

---

# Profile Size

Appify displays the storage used by an application's browser profile directly in the interface. The profile size is calculated by walking the profile directory. No external tools are required.

---

# Wrapper Regeneration

Wrappers contain environment-specific information such as the display server and browser launch configuration.

Rather than permanently coupling an application to the environment in which it was originally installed, Appify stores the application's settings separately in `profile.json`.

Wrapper regeneration reads the metadata and produces the same launcher that a fresh installation would generate using the current system environment. This is why you can switch between X11 and Wayland without reinstalling every application.

Use **☰ Menu → Regenerate All Wrappers** to regenerate the entire installed application library at once.

---

# Migration and Data Import/Export

Appify previously stored its data in:

```text
~/.pwa_manager/
```

Version 2.2.3 introduced the migration system to:

```text
~/.appify/
```

Migration is safe and user-controlled. On first launch, Appify asks for confirmation before migrating. Migration can also be started manually through **☰ Menu → Migrate to .appify…**.

The old directory is not deleted until the user confirms the migration. After migration, Appify displays a notice explaining that browser extensions may need repair because of browser sandbox limitations.

## Export All Data

Appify can export the complete `~/.appify/` directory into a ZIP archive containing:

* Profiles
* Scripts
* Backups
* Configuration
* Application metadata
* Other Appify data

## Import All Data

Importing restores a previous Appify data export. Before doing so, Appify automatically backs up the current data.

Imported application wrappers are regenerated for the current machine, allowing the imported library to adapt to:

* Different installed browsers
* Wayland/X11
* Native/Flatpak/Snap browser installations
* Current system paths

Browser extensions cannot be transferred reliably because of browser sandbox restrictions.

---

# Firefox CSS Technical Details

Text pasted into the Firefox Advanced Options fields is written verbatim to:

```text
<profile>/chrome/userChrome.css
<profile>/chrome/userContent.css
```

Appify automatically sets `toolkit.legacyUserProfileCustomizations.stylesheets` in the application's generated `user.js`.

The CSS fields are raw paste fields rather than file pickers. Copy CSS from [firefoxcss-store.github.io](https://firefoxcss-store.github.io/) and paste it directly into Appify.

Only CSS is supported. Layouts requiring `.js` files will not be fully applied.

---

# Self-Update Technical Details

Appify checks the GitHub Releases API during startup using a background thread. If a newer stable release is available, Appify displays an update notification.

The Griffin updater detects whether Appify is running from a `.deb` installation or an AppImage. The detection uses `dpkg` for Debian installations and `$APPIMAGE` for AppImage installations.

The updater can then download and install the appropriate release.

Scheduled update checks use systemd timers and can be configured for:

* Hourly
* Daily at a specific time
* Weekly
* Custom `OnCalendar` expressions

---

# Community and Support

* **Discord:** [Join Here](https://discord.gg/7fEt5W7DPh)
* **Patreon (Beta Builds):** [Patreon](https://www.patreon.com/c/BobbyComet/membership)
* **Support the Griffin Project:** [Ko-fi](https://ko-fi.com/bobby60908)

[FAQs](https://github.com/bobbycomet/Appify/wiki/FAQs)
[How to Debug](https://github.com/bobbycomet/Appify/wiki/How-to-debug)

If you're upgrading from an older version and encounter migration issues, start with the FAQ and debugging documentation.

---

# Tools That Pair Well With Appify

### [Griffin Updater](https://github.com/bobbycomet/GriffinUpdater)

Downloads and continuously updates Griffin tools without requiring you to manually visit GitHub.

### [Sentry](https://github.com/bobbycomet/Process-Sentry)

Process Sentry includes flags designed specifically to avoid slowing down Appified applications.

### [Kernel Autotune](https://github.com/bobbycomet/kernel-autotune-V2)

Tunes the system for performance and complements both Sentry and Appify.

---

# License

Appify is licensed under the **GPLv3**.

Forks and derivative projects are welcome. If you build on Appify:

* Keep the GPLv3 license terms intact.
* Give appropriate credit to the original Appify project.
* Include a link back to this repository where practical.

If you build something cool with Appify, I'd love to hear about it.

---

# Branding

The **Appify** and **Griffin Linux** names, logos, and branding are **not covered by the GPL license**.

They may not be used to imply endorsement or official affiliation without permission.

Forks are encouraged, but modified versions should be renamed and rebranded unless permission has been granted to use the original branding.

---

<div align="center">
  <img src="https://raw.githubusercontent.com/bobbycomet/Appify/main/Griffin-G.png" alt="Griffin Linux" width="15%"/>

  <p>
    <strong>Griffin Linux. Where power meets simplicity.</strong><br/>
    Made with Windows switchers in mind. Built for everyone who wants a better PC.
  </p>
</div>
