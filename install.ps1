[CmdletBinding()]
param(
    [string]$Destination = (Join-Path $env:USERPROFILE '.codex\skills'),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$packageRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceRoot = Join-Path $packageRoot 'skills'
$skillNames = @('boundless-ai-director-writer', 'boundless-ai-director')
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

foreach ($skillName in $skillNames) {
    $source = Join-Path $sourceRoot $skillName
    $target = Join-Path $Destination $skillName

    if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md'))) {
        throw "Invalid package: missing $skillName\SKILL.md"
    }

    if (Test-Path -LiteralPath $target) {
        if (-not $Force) {
            throw "Already installed: $target. Re-run with -Force to create a backup and replace it."
        }
        $backup = "$target.backup-$timestamp"
        Move-Item -LiteralPath $target -Destination $backup
        Write-Output "Backed up: $backup"
    }

    Copy-Item -LiteralPath $source -Destination $target -Recurse
    Write-Output "Installed: $target"
}

Write-Output 'Installation complete. Start a new Codex task to reload skills.'
