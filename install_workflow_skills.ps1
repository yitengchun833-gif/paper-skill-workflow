[CmdletBinding()]
param(
    [string]$SkillsRoot = (Join-Path $env:USERPROFILE ".codex\skills"),
    [string[]]$Name,
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

function Get-FullPathSafe {
    param([Parameter(Mandatory = $true)][string]$Path)
    return [System.IO.Path]::GetFullPath($Path)
}

function Assert-ChildPath {
    param(
        [Parameter(Mandatory = $true)][string]$Parent,
        [Parameter(Mandatory = $true)][string]$Child
    )

    $parentFull = Get-FullPathSafe $Parent
    $childFull = Get-FullPathSafe $Child
    $prefix = $parentFull.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar

    if (-not $childFull.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to write outside target skills root: $childFull"
    }
}

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ManifestPath = Join-Path $ScriptRoot "workflow_manifest.json"

if (-not (Test-Path -LiteralPath $ManifestPath)) {
    throw "Missing manifest: $ManifestPath"
}

$Manifest = Get-Content -LiteralPath $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
$InstallableSkills = @($Manifest.installableSkills | Where-Object { $_.installable -eq $true })

if ($Name -and $Name.Count -gt 0) {
    $requested = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($item in $Name) {
        [void]$requested.Add($item)
    }
    $InstallableSkills = @($InstallableSkills | Where-Object { $requested.Contains($_.name) })

    foreach ($item in $Name) {
        if (-not ($InstallableSkills | Where-Object { $_.name -ieq $item })) {
            throw "Skill not found in workflow manifest: $item"
        }
    }
}

New-Item -ItemType Directory -Path $SkillsRoot -Force | Out-Null
$TrashRoot = Join-Path $SkillsRoot ".trash"

foreach ($skill in $InstallableSkills) {
    $relativePath = $skill.exportPath.Replace("/", [System.IO.Path]::DirectorySeparatorChar)
    $sourcePath = Join-Path $ScriptRoot $relativePath
    $targetPath = Join-Path $SkillsRoot $skill.name

    if (-not (Test-Path -LiteralPath $sourcePath)) {
        throw "Missing exported skill directory: $sourcePath"
    }

    Assert-ChildPath -Parent $ScriptRoot -Child $sourcePath
    Assert-ChildPath -Parent $SkillsRoot -Child $targetPath

    if (Test-Path -LiteralPath $targetPath) {
        if ($NoBackup) {
            Remove-Item -LiteralPath $targetPath -Recurse -Force
        }
        else {
            New-Item -ItemType Directory -Path $TrashRoot -Force | Out-Null
            $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
            $backupPath = Join-Path $TrashRoot "$stamp-$($skill.name)"
            Move-Item -LiteralPath $targetPath -Destination $backupPath
            Write-Host "Backed up existing $($skill.name) to $backupPath"
        }
    }

    Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Recurse -Force
    Write-Host "Installed $($skill.name) -> $targetPath"
}

Write-Host "Done. Restart Codex to pick up new or updated skills."

