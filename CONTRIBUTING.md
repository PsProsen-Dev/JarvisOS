# Contributing to JarvisOS

JarvisOS is a community-maintained Windows 11 AME playbook built for developers. Every bug fix, registry tweak, and documentation improvement helps the community.

---

## Quick Links

- [Open an Issue](https://github.com/PsProsen-Dev/JarvisOS/issues/new/choose)
- [Read the Docs](https://jarvisos.mintlify.app)
- [Full Contributing Guide (Wiki)](https://github.com/PsProsen-Dev/JarvisOS/wiki/Contributing)
- [Playbook Architecture (Wiki)](https://github.com/PsProsen-Dev/JarvisOS/wiki/Playbook-Architecture)
- [Security Policy](https://github.com/PsProsen-Dev/JarvisOS/security)

---

## Scope — What JarvisOS Accepts

| ✅ In Scope | ❌ Out of Scope |
|------------|----------------|
| Privacy / telemetry improvements | Xbox / Game Bar features |
| Dev tool additions | Steam / gaming integrations |
| Browser / office option additions | Consumer app additions |
| Bug fixes and compatibility patches | Features removing WSL2 / Hyper-V |
| Documentation updates | Gaming network tweaks |

JarvisOS is a **developer-only** playbook. There are no gaming modes, no Xbox options, and no gaming-specific tweaks.

---

## How to Contribute

1. **Fork** the repository
2. **Create a branch**: `git checkout -b fix/your-fix-name`
3. **Make your change** in the relevant YAML or config file
4. **Test in a VM** — mandatory before any PR (VMware / VirtualBox / Hyper-V)
5. **Commit**: `git commit -m "fix(registry): description — source if applicable"`
6. **Open a Pull Request** against `master`

---

## Testing Requirements

- All playbook changes **must** be tested in a virtual machine
- Note the Windows 11 build number you tested on
- Verify WSL2 and Hyper-V still work after your change (if relevant)
- Never submit untested registry or service changes

---

## Code Style

- Single quotes for YAML string values
- **Decimal format** for `REG_DWORD` values — never hex strings (causes `FormatException`)
- Explicit `startType` on all `!service` actions
- Option IDs in kebab-case: `install-git`, `browser-brave`

---

## Reporting Issues

Use the [issue templates](https://github.com/PsProsen-Dev/JarvisOS/issues/new/choose):

- **Bug Report** — something broke after applying the playbook
- **Playbook Issue** — specific YAML task caused a problem
- **Feature Request** — suggest a new option or tweak
- **Hardware Compatibility** — hardware not working after install

---

## Security Vulnerabilities

**Do not open a public issue for security vulnerabilities.**

Report privately via [GitHub Security Advisories](https://github.com/PsProsen-Dev/JarvisOS/security/advisories/new).

See [SECURITY.md](SECURITY.md) for the full policy.

---

## Code of Conduct

Be respectful. This is a developer community — everyone is welcome regardless of experience level. Keep discussions technical and constructive.
