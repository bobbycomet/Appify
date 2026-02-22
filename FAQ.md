# Appify – Frequently Asked Questions (FAQ)

## What is Appify?

Appify is a Linux desktop utility that turns any website into a **real, isolated desktop app** using your **already-installed browser**. Each app runs in its own browser profile with its own cookies, logins, storage, and extensions—without Electron, Flatpak sandboxing, or duplicated runtimes.

---

## Is Appify an “advanced” tool?

**To use: no.**

Appify is fully GUI-driven and follows a simple flow:

1. Pick a site (or paste a URL)
2. Choose a browser
3. (Optional) Add extensions
4. Click Install

Installs typically complete in **under one second**.

**Internally: yes.** Appify handles browser detection, profile isolation, Wayland/X11 differences, security hardening, and performance tuning automatically so users never have to.

---

## How is this different from Chrome/Edge “Install as App”?

Browser PWAs are mostly shortcuts that reuse your **main browser profile**.

Appify creates:

* A **separate browser profile per app**
* **Per-app extensions** (e.g. BTTV only for Twitch)
* **Independent taskbar icons and windows**
* **No shared cookies, history, or telemetry**

This results in true isolation and cleaner workflows.

---

---

## One-sentence summary

**Appify makes web apps behave like real Linux applications by isolating them correctly, launching them instantly, and staying out of the user’s way.**

## Will my data be safe?

Yes. All Appify data is stored locally in your home directory at:
`/home/user/.pwa_manager`

Each PWA runs in its own isolated browser profile. Any data leaks or cross-site storage issues are contained entirely within that local profile. No other PWAs—and not even your main browser—can see or access this data.

## What PWAs can be made?

Any website.

There are no site restrictions or domain limitations. If it runs in a browser, Appify can appify it.

---

## Does Appify bundle a browser?

No.

Appify **never ships or downloads a browser**. It only uses browsers already installed on your system (native, Flatpak, or Snap), such as:

* Firefox
* Chromium
* Chrome
* Edge
* Brave
* Vivaldi
* Opera
* Ungoogled Chromium

This avoids duplicated runtimes and keeps security updates under distro control. If the browser updates, the app updates.

---

## Does Appify use Electron?

No.

Appify does not wrap websites in Electron or ship its own Chromium build. All apps run in your real browser with native Wayland/X11 support.

---

---

## Issues with Flatpaks due to Flatpak sandboxing

Flatpak Firefox is not recognizing my controller—Flatpak issue, not Appify's. It can't be worked around in Appify.

Flatpak does not show the app icon—Flatpak issue, not Appify's. It can't be worked around.

I get weird screen tears. If you are using Nvidia and X11, use Nvidia X Server Settings (with sudo), choose X server Display Configuration, click advanced, checkmark Force Full Composition Pipeline, then Save to X Configuration File, Apply, and Save. This method can be applied if you have this in other apps, not just Flatpak.

---

---

## WebHID issue

Xbox Xcloud is not seeing my controller. Use native Firefox, no WebHID needed. Chromium browsers and Xcloud do not like each other with WebHID. This is an Xbox issue, not Appify's.

---

## Is Appify safe to use?

Yes. Appify is designed with a conservative security posture:

* Profile directories are created with **`0700` permissions**
* Config files are written atomically with **`0600` permissions**
* URLs are validated (`http/https` only; `file:`, `data:`, `javascript:` blocked)
* Shell arguments are sanitized and quoted
* Downloaded icons are size-limited and magic-byte validated

Appify runs entirely in **user space** and does not require elevated privileges.

---

## Does Appify run background services or daemons?

No.

Appify does not install services, daemons, or background processes. It only runs when you launch the Appify GUI or when you start an installed app.

---

## What happens if I uninstall Appify?

Uninstalling Appify:

* Removes the Appify application
* **Does not delete your app profiles by default**

If you reinstall Appify later, your apps can pick up exactly where they left off. You may manually delete profiles if desired.

---

## Can I back up my apps?

Yes.

Appify can back up:

* Cookies
* Logins
* Site storage
* History

**Extensions are not included in backups** due to browser limitations. Before backing up, remove extensions, then reinstall them after restoring.

---

## Why don’t extensions get backed up?

Browsers store extension data in internal locations outside the normal profile structure. Including them risks corruption or crashes.

This is a browser limitation, not an Appify design choice.

---

---

## Can I manually add extensions?

Yes.

You have two options:

* **Add Custom**: Allows you to add an extension via a direct link and assign it a name. This method is tracked by Appify and included in management features.
* **Open Store**: Opens the full tabbed browser UI for that specific PWA instance. You can install extensions directly from the browser’s extension store.

⚠️ Extensions added via **Open Store** are **not** tracked by Appify. If you want Appify to manage and track extensions, use **Add Custom**.

---

## Why did my GUI freeze and force-quit, and now my backup folder has an incomplete backup?

This is expected behavior when extensions are involved.

Extensions are third-party tools and do not reliably store their state within the browser profile itself. Including them in backups would introduce a high risk of corruption or instability.

Because of this:

* Extensions are excluded from backups by design
* To prevent data corruption caused by third-party extensions, Appify may halt a backup if it detects an unstable extension state. It can cause the GUI to crash
* This is because of browser behavior, not Appify

This behavior is intentional, and extension-inclusive backups are **not planned**.

---

## Does Appify support Wayland?

Yes.

Appify detects your compositor (GNOME, KDE, Sway, Hyprland, COSMIC, etc.) and applies the correct Wayland flags automatically. Firefox and Chromium-based browsers receive compositor-appropriate handling.

---

## Is Appify compatible with X11?

Yes. Appify works on both **Wayland and X11** sessions and automatically adapts at runtime.

---

## Does Appify work with controllers and cloud gaming?

Yes.

Appify supports:

* WebHID
* Gamepad APIs
* Kiosk mode
* GPU acceleration
* Performance tuning (nice / ionice)

It includes presets for major cloud gaming platforms.

---

## How fast is Appify?

Typical install times are **well under one second**.

The slowest measured install during testing was approximately **0.68 seconds**, thanks to ghost profiles and zero runtime downloads.

---

## Does Appify collect telemetry?

No.

Appify does not collect analytics, usage data, or telemetry. Any telemetry comes solely from the browser you choose to run.

---

## Is Appify open source?

Yes. Appify is open source and available on GitHub. Users are encouraged to audit the code, file issues, and contribute.

---

## Why isn’t Appify available as a Flatpak?

Flatpak sandboxing interferes with:

* Browser detection
* Extension installation
* Profile isolation
* Wayland/X11 switching
* WebHID and controller support

For these reasons, Appify ships as a native application.

---

## Will Appify support Windows?

A Windows port is in development. The isolation model and browser orchestration are being adapted for Windows environments.

---

## Who is Appify for?

Appify is ideal for:

* Linux users who want real web apps
* Streamers and VTubers
* Cloud gamers
* Developers managing multiple accounts
* Privacy-conscious users
* Wayland users who want things to just work

---

## Where can I get help or contribute?

* GitHub Issues: bug reports and feature requests
* Discord: community support and discussion
* Patreon / Ko-fi: early builds and project support

## Why is my Discord PWA not sending system notifications?

You need to enable notifications inside the **instance browser settings**, not your main browser.

Steps:

1. Use **Open Store** to open the tabbed browser view for that PWA instance
2. Go to the browser’s settings
3. Enable **System Notifications** (or equivalent)
4. Fully close **both** the tabbed instance and the PWA instance

The setting will only apply after both are closed and relaunched.

---

## Why is YouTube saying “Content unavailable”?

This is not caused by Appify.

YouTube actively fights ad blockers and content-modifying extensions. To diagnose:

* Check whether the video plays with extensions disabled
* Press **F5** to refresh (this may allow the current video to play temporarily)

If the issue is extension-related, you’ll need to wait for the extension to update. Appify does not control or modify extension behavior.

---
## How much disk space do PWAs created by Appify use?

It depends entirely on what the site does and which extensions are installed.

During testing, Appify PWAs ranged from:

* ~27 MB (e.g. Gmail with no extensions)
* Up to ~1.4 GB (e.g. Twitch or Kick with ~3 extensions)

This range is normal and expected for fully isolated browser profiles.

## Why this is considered low

* Appify PWAs are real browser instances with real profiles, not shortcuts or wrappers. Disk usage reflects actual browser behavior:
* Cached media (video, thumbnails, audio buffers)
* IndexedDB and localStorage
* WASM modules
* Extension data (BTTV, FFZ, 7TV, ad blockers, etc.)
* A 27 MB PWA is extremely small for a real browser profile and indicates:
* Minimal cache
* No heavy media pipelines
* Few or no extensions
* A 1.4 GB streaming PWA is normal because:
* Video platforms cache aggressively for performance
* Extensions maintain their own databases and assets
* Browser profiles are intentionally isolated and not deduplicated

## Compared to other approaches

### Electron apps

* Typically ship 200–400 MB upfront per app
* Include their own Chromium runtime
* Still grow further with user data
* Multiple Electron apps duplicate the same runtime repeatedly

### Traditional PWAs / “Install as App”

* Reuse your main browser profile
* Hide disk usage by mixing data with everything else
* Offer no isolation or per-app control
* Disk growth still occurs, just less visible

### Native apps

* Often smaller at install time
* Still create caches, config, and runtime data over time
* Do not provide browser-level isolation or per-site sandboxing

## Why Appify does not reduce or compress this
Appify intentionally avoids:
* Profile deduplication hacks
* Shared cache tricks
* Unsafe extension copying
* Background cleanup services

Those approaches risk data corruption, crashes, or privacy leaks.

Appify shows the real cost of isolation and leaves control in the user’s hands.

So, 17 apps made in total can reach 6.3 GB from testing, with all the heavy hitters, YouTube, Kick, two anime sites, and Twitch, all active, came out to be 6.8 GB. This is for all 17 apps, not individual; 6.3 GB for one would be insane.

## What is the RAM usage?

Google Docs uses only 300 Mb-500 Mb depending on whether you have addons.

Running something doing more like, YouTube took up 1-1.2 GB of RAM (2 extensions, Sponsor block, Pie adblock), and running Twitch took up 1.3-1.5 GB of RAM (4 Extensions, Pie adblock, 7tv, Better TV, Frankerfacez). This is on par with average Microsoft Edge browser behavior. This is because of the kind of sites they are, and the extension scripts like to take more RAM, but this is expected with just a normal tab.

Compared to Electron wrappers: no 100–300 MB duplicated runtime per app, lower total footprint for multiple sites, some Electron apps can get up to 4 GB in RAM alone.
---
