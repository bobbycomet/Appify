# Security Policy

## Supported Versions

Only the latest stable release of Appify receives security fixes. Please update to the current version before reporting a vulnerability.

| Version | Supported |
|---|---|
| 2.1.1 (latest) | ✅ |
| 2.0.x | ❌ |
| 1.x | ❌ |

---

## Reporting a Vulnerability

**Please do not open a public GitHub issue for security vulnerabilities.** Public disclosure before a fix is available puts other users at risk.

Report security issues privately through one of the following channels:

- **Discord (preferred):** https://discord.gg/7fEt5W7DPh — send a direct message to BobbyComet
- **Email:** griffin.linux@gmail.com

### What to Include

A useful report contains:

1. **Type of issue** — e.g., path traversal, shell injection, privilege escalation, information disclosure
2. **Affected file and location** — which script or function is involved
3. **Steps to reproduce** — a clear, minimal set of steps that trigger the issue
4. **Proof of concept** — a script, command, or screenshot demonstrating the vulnerability
5. **Upstream check** — does this issue exist in a dependency (GTK, Python stdlib, curl) rather than in Appify itself?

The more detail you provide, the faster the issue can be triaged and fixed.

---

## Bounty Program

Appify is a solo open-source project and does not currently offer financial bounties. Confirmed vulnerability reporters will receive credit in the project's contributors list and release notes.

---

## Security Architecture

The following is a summary of the security measures built into Appify 2.1.0. This context may be useful when evaluating whether a behaviour is a bug or a known limitation.

### File Operations

- **Atomic writes** — `config.json` and all `profile.json` files are written to a `.tmp` file first, then renamed into place atomically. An interrupted write cannot produce a corrupt config.
- **Restricted permissions** — `config.json` and `profile.json` files are created with `0o600` (owner read/write only). Profile directories are created with `0o700` (owner access only).
- **Profile directory isolation** — each PWA lives in its own `~/.pwa_manager/profiles/<slug>/` directory. Appify never traverses outside `~/.pwa_manager/` for any write operation.

### Shell and URL Handling

- **Shell metacharacter sanitization** — all user-supplied values (URLs, app names, profile paths) are run through `sanitize_shell_string()` before being embedded in generated bash scripts. This strips characters that could be interpreted as shell metacharacters even inside double-quoted strings.
- **URL validation** — `validate_url()` rejects anything that is not a strict `http://` or `https://` URL with a non-empty hostname. `data:`, `file:`, `javascript:`, `ftp:`, and all other schemes are refused. URLs longer than 2048 characters are also rejected.
- **Launcher path guard** — when launching an app from the CLI (`--launch-app`), Appify resolves the wrapper script path and confirms it lies within `~/.pwa_manager/scripts/` before executing it. A path that resolves outside this directory is rejected.

### Backup and Restore

- **Archive member validation** — before extracting anything from a backup archive, every `TarInfo` member is inspected. The following are rejected:
  - Absolute paths (e.g., `/etc/passwd`)
  - Path-traversal sequences (e.g., `../../etc/passwd`)
  - Symlinks or hard-links whose resolved target escapes the extraction directory
  - Device files and FIFOs
- **Backup directory confinement** — restore operations confirm the provided backup path resolves within `~/.pwa_manager/.backup/` before opening the archive. A path outside this directory is rejected with an error.

### Icon Downloads

- **Magic-byte validation** — after downloading an icon, Appify reads the first 8 bytes of the file and confirms they match a known image format (PNG, JPEG, GIF, ICO, BMP, or WebP). Files that fail this check are deleted rather than kept.
- **File size cap** — icon downloads are capped at 2 MB via `curl --max-filesize`. Files exceeding this limit are refused.
- **Protocol restriction** — `curl` is invoked with `--proto https,http`, preventing `file://`, `ftp://`, and other schemes from being used even if a malicious redirect attempts it.

### Extension Store URLs

Extension store URLs from presets and user-supplied custom extensions are validated against an allowlist of known hosts before being passed to the browser:

```
chromewebstore.google.com
microsoftedge.microsoft.com
addons.mozilla.org
addons.opera.com
workspace.google.com
```

Any URL whose host does not match this allowlist is skipped and a warning is written to the log.

### Known Limitations

- **No Flatpak sandbox for Appify itself** — Appify is intentionally not distributed as a Flatpak because sandboxing breaks browser detection, profile isolation, Wayland/X11 switching, and controller support. This is a design decision, not a vulnerability.
- **Generated shell scripts are executable** — launcher scripts at `~/.pwa_manager/scripts/` are `chmod 0o755`. An attacker with write access to `~/.pwa_manager/` could modify these scripts. Protecting your home directory from unauthorized write access is outside Appify's threat model.
- **Config is plain JSON** — `config.json` is not encrypted. Sensitive browser session data lives in the browser profile directories, not in Appify's config.

---

## Disclosure Timeline

Once a valid vulnerability report is received:

1. Acknowledgement within **3 business days**
2. Triage and severity assessment within **7 days**
3. Fix developed and tested
4. Patched release published
5. Reporter credited in release notes (unless anonymity is requested)

---

*© 2025 BobbyComet — Appify is licensed under GPL-3.0*
