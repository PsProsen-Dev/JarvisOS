🚀 **JarvisOS 11.06.26 - Triple Helix (Atlas/Revi Blind Merge + Privacy+ Cherry-Pick)**

*ℹ️ Versioning Philosophy: JarvisOS versions are based on the release date in the `DD.MM.YY` format. This release corresponds to June 11, 2026.*

### What's New:
* **The True Triple Helix Merge**: Executed a 100% blind merge of the ENTIRE ReviOS 26.04 playbook AND the ENTIRE AtlasOS v0.5.0 playbook. No cherry-picking. 
* **NOVA Network Overhaul**: Replaced standard TCP congestion control with Google's **BBRv2** for massive latency reduction. Enabled Network QoS (DSCP 46 Priority) automatically for major esports titles (Valorant, CS2, Fortnite, Apex, etc.).
* **Advanced Performance Tuning**: Integrated Multimedia Class Scheduler (MMCSS) optimizations for Gaming and Pro Audio. Deprioritized background tasks (Telemetry, Update broker) to lowest CPU priority.
* **Mereng-OS Footprint**: Integrated aggressive `DISM /ResetBase` component store cleanup to shrink the OS installation footprint down to ~8GB-10GB. Note: This removes the ability to uninstall previous Windows Updates.
* **Gaming vs Developer OS Profile**: At the start of the AME Wizard, you can now explicitly choose if your PC is used for Gaming or Development. The Developer profile automatically purges Xbox overlay features and gaming bloatware that gamers need but devs hate.
* **Settings Visibility Overrides**: Overrode Privacy+ aggressive settings hiding. Normal settings are now visible, but specific broken/removed features remain hidden to prevent system crashes.
* **Permanent Bloatware Deletion**: Forcefully and permanently nukes the following from the system image:
   - "Get Started" (Microsoft.Getstarted)
   - "Windows Backup" (Microsoft.WindowsBackup)
   - "Windows Media Player Legacy" (WindowsMediaPlayer Feature)
* **Mail Client Selection**: Added a new UI option to either keep native Windows Mail clients or completely strip them out if you prefer Web Mail (Gmail, Outlook Web, etc).
* **Multi-Browser Setup**: The browser selection in the UI has been upgraded to a multi-select Checkbox page. You can now install Brave, LibreWolf, Zen, and BrowserOS simultaneously!
* **Enhanced Security (Sudo UAC)**: Built-in Administrator account is disabled. UAC now behaves like Linux `sudo`.
* **Bitdefender VPN Auto-Cleanup**: The offline Bitdefender installer bundles a VPN. The playbook now automatically and silently uninstalls the VPN.
* **Privacy+ Deep Hardening**: 112+ telemetry/privacy tweaks injected, with specific fixes for `cloudidsvc`, `ClipSVC`, and `LicenseManager`.
