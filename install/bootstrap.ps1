#Requires -Version 5.1
<#
.SYNOPSIS
    Installs the AI agent rules into a project folder.
.PARAMETER Target
    Project root to install into.
.EXAMPLE
    .\bootstrap.ps1 -Target C:\dev\myproject
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$Target
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot

if (-not (Test-Path -LiteralPath $Target)) { throw "Target not found: $Target" }

$map = [ordered]@{
    'copilot/copilot-instructions.md'                  = '.github/copilot-instructions.md'
    'copilot/instructions/memory-bank.instructions.md' = '.github/instructions/memory-bank.instructions.md'
    'copilot/prompts/mb-prune.prompt.md'               = '.github/prompts/mb-prune.prompt.md'
}

foreach ($key in $map.Keys) {
    $src = Join-Path $repo $key
    $dst = Join-Path $Target $map[$key]
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $dst) | Out-Null
    Copy-Item -LiteralPath $src -Destination $dst -Force
    Write-Host "copied $($map[$key])"
}

$bank = Join-Path $Target 'memory-bank'
if (Test-Path -LiteralPath $bank) {
    Write-Host 'memory-bank/ already exists, left untouched'
} else {
    Copy-Item -LiteralPath (Join-Path $repo 'template') -Destination $bank -Recurse
    Write-Host 'created memory-bank/ with seven skeleton files'
}

Write-Host ''
Write-Host 'Done. Next:'
Write-Host '  1. Fill in memory-bank/summary.md'
Write-Host '  2. Add user/global-tone.md at user scope if you want the voice rules'
Write-Host '  3. Start a new chat and confirm the agent reads summary.md first'
