<#
.SYNOPSIS
    Moon Sweepers Backup Browser — Read-Only Windows Diagnostic Script
.DESCRIPTION
    Performs non-invasive, read-only local checks on Windows (Steam paths, folder layout,
    file timestamps/sizes, and system info). Does NOT modify, delete, or upload any files,
    and does NOT require administrator privileges or changes to Windows Defender.
.NOTES
    License: MIT
#>

$ErrorActionPreference = 'SilentlyContinue'

function Get-SteamLibraries {
    $libs = @()
    $regPath = 'HKCU:\Software\Valve\Steam'
    $steamPath = (Get-ItemProperty -Path $regPath -Name 'SteamPath').SteamPath
    if (-not $steamPath) {
        $steamPath = 'C:\Program Files (x86)\Steam'
    }
    $steamPath = $steamPath -replace '/', '\'
    if (Test-Path $steamPath) {
        $libs += $steamPath
        $vdf = Join-Path $steamPath 'steamapps\libraryfolders.vdf'
        if (Test-Path $vdf) {
            $content = Get-Content -Path $vdf -Raw
            $matches = [regex]::Matches($content, '"path"\s+"([^"]+)"')
            foreach ($m in $matches) {
                $p = $m.Groups[1].Value -replace '\\', '\'
                if ((Test-Path $p) -and ($libs -notcontains $p)) {
                    $libs += $p
                }
            }
        }
    }
    return $libs
}

function Find-SteamGameDir {
    param([string[]]$FolderNames)
    foreach ($lib in (Get-SteamLibraries)) {
        foreach ($name in $FolderNames) {
            $candidate = Join-Path $lib "steamapps\common\$name"
            if (Test-Path $candidate) {
                return $candidate
            }
        }
    }
    return $null
}

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host " Moon Sweepers Backup Browser (Read-Only Check)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

$baseDir = "$env:USERPROFILE\AppData\LocalLow\DragDropGames\MoonSweepers"
$backupDir = Join-Path $baseDir "Backups"

Write-Host "[Moon Sweepers Save & Backup Inventory]" -ForegroundColor Yellow
if (Test-Path $baseDir) {
    Write-Host "  Base Folder   : $baseDir" -ForegroundColor Green
    $liveFiles = Get-ChildItem -Path $baseDir -File
    foreach ($f in $liveFiles) {
        $kb = [math]::Round($f.Length / 1KB, 2)
        Write-Host ("    [Live]   {0,-32} | {1,8} KB | {2}" -f $f.Name, $kb, $f.LastWriteTime)
    }
} else {
    Write-Host "  Base folder not found at $baseDir" -ForegroundColor DarkYellow
}

Write-Host ""
if (Test-Path $backupDir) {
    Write-Host "  Backup Folder : $backupDir" -ForegroundColor Green
    $backups = Get-ChildItem -Path $backupDir -File -Recurse | Sort-Object LastWriteTime -Descending
    Write-Host "  Total backup files: $($backups.Count)"
    foreach ($b in ($backups | Select-Object -First 25)) {
        $kb = [math]::Round($b.Length / 1KB, 2)
        Write-Host ("    [Backup] {0,-32} | {1,8} KB | {2}" -f $b.Name, $kb, $b.LastWriteTime)
    }
} else {
    Write-Host "  Backups subfolder not found." -ForegroundColor DarkYellow
}

Write-Host ""
Write-Host "Diagnostic complete. No files were modified." -ForegroundColor Green
Read-Host "Press Enter to exit"
