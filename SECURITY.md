# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| 30.05.26 (latest) | ✅ Active |
| < 30.05.26 | ❌ No longer supported |

Always use the latest release from [GitHub Releases](https://github.com/PsProsen-Dev/JarvisOS/releases/latest).

---

## Reporting a Vulnerability

**Do not open a public GitHub Issue for security vulnerabilities.**

If you discover a vulnerability in JarvisOS — including unsafe registry operations, a playbook action that unintentionally weakens security posture, a malicious download URL, or a privilege escalation risk — report it privately:

### Option 1 — GitHub Private Advisory (Preferred)

Use GitHub's built-in private vulnerability reporting:

👉 [Report a vulnerability](https://github.com/PsProsen-Dev/JarvisOS/security/advisories/new)

This creates an encrypted, private advisory visible only to maintainers.

### Option 2 — Email

If the advisory system is unavailable, contact the maintainer directly via GitHub profile: [@PsProsen-Dev](https://github.com/PsProsen-Dev)

---

## What to Include in Your Report

To help us respond quickly, please include:

- **JarvisOS version** affected (e.g., `30.05.26`)
- **Affected file** — which YAML, script, or config file
- **Description** of the vulnerability and potential impact
- **Reproduction steps** — how to trigger the issue
- **Proposed fix** (optional but appreciated)

---

## What Qualifies as a Security Issue

We treat the following as security vulnerabilities:

| Category | Examples |
|----------|---------|
| **Malicious download URL** | A browser/tool installer URL pointing to a compromised source |
| **Privilege escalation** | A playbook action granting unintended elevated access |
| **Unsafe registry write** | A registry change that weakens OS security posture unintentionally |
| **Credential exposure** | Any hardcoded key, token, or password in scripts |
| **Unsigned executable** | An included `.exe` or `.bat` that is unsigned or tampered |
| **Unsafe PowerShell** | A script action with injection risk or unsafe remote execution |

---

## Out of Scope

The following are **not** considered security vulnerabilities in JarvisOS:

- Removing Windows Defender (this is an explicit user-selected optional feature)
- Disabling Windows Update (this is by design — see docs)
- Removing Microsoft telemetry services (this is the core purpose of the playbook)
- Anti-cheat incompatibility (JarvisOS is not designed for gaming)
- Features broken by Microsoft Windows Updates after playbook application

---

## Response Timeline

| Stage | Timeline |
|-------|----------|
| Acknowledgement | Within 48 hours |
| Initial assessment | Within 7 days |
| Fix or mitigation | Within 14 days for critical issues |
| Public disclosure | After fix is released |

---

## Scope of This Playbook

JarvisOS is a **local, offline playbook** applied once to a Windows 11 installation. It does not:

- Operate as a server or cloud service
- Process user data or transmit telemetry
- Manage multi-tenant or shared environments

Security concerns are primarily around the integrity of the playbook files themselves (scripts, executables, download URLs) and the correctness of system modifications.

---

*Thank you for helping keep JarvisOS safe for the community.*
