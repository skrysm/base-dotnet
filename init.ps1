#!/usr/bin/env pwsh
param(
    [string] $KeepGitCleanFiles = 'yes',

    [Parameter(Mandatory=$True)]
    [string] $SolutionName
)

# Stop on every error
$script:ErrorActionPreference = 'Stop'

# NOTE: The cast to [bool] is required (for some reason); if we didn't
#   do this here, '$KeepGitCleanFiles' would remain a string.
[bool] $KeepGitCleanFiles = switch ($KeepGitCleanFiles) {
    'yes'    { $true }
    'true'   { $true }
    '$true'  { $true }

    'no'     { $false }
    'false'  { $false }
    '$false' { $false }

    default { Write-Error "Invalid input: $KeepGitCleanFiles" }
}

$SolutionName = $SolutionName.TrimEnd('.sln')

Write-Host -ForegroundColor Cyan 'Removing ".git"...'
Remove-Item "$PSScriptRoot/.git" -Recurse -Force

Write-Host -ForegroundColor Cyan 'Removing "README.md"...'
Remove-Item "$PSScriptRoot/README.md"

# NOTE: The license is just for the base repo. It doesn't apply to
#   the newly created repo/project.
Write-Host -ForegroundColor Cyan 'Removing "LICENSE.txt"...'
Remove-Item "$PSScriptRoot/LICENSE.txt"

Write-Host -ForegroundColor Cyan 'Removing "init.ps1"...'
Remove-Item "$PSScriptRoot/init.ps1"

Write-Host -ForegroundColor Cyan 'Removing "docs/"...'
Remove-Item "$PSScriptRoot/docs" -Recurse -Force

Write-Host -ForegroundColor Cyan 'Removing "_StyleGuide/"...'
Remove-Item "$PSScriptRoot/_StyleGuide" -Recurse -Force

if (-Not $KeepGitCleanFiles) {
    Remove-Item "$PSScriptRoot/git-clean.cmd"
    Remove-Item "$PSScriptRoot/git-clean.sh"
}


Write-Host -ForegroundColor Cyan 'Removing "_keep.txt" files...'
Remove-Item "$PSScriptRoot/*/_keep.txt" -Recurse -Force

Rename-Item "$PSScriptRoot/_BlankSolution.sln" "$PSScriptRoot/$SolutionName.sln"
Rename-Item "$PSScriptRoot/_BlankSolution.sln.DotSettings" "$PSScriptRoot/$SolutionName.sln.DotSettings"


Write-Host
Write-Host -ForegroundColor Cyan 'Initializing new Git repository...'
$gitVersion = & git version
if ($gitVersion -ge 'git version 2.28.0') {
    & git init --initial-branch=main "$PSScriptRoot"
}
else {
    & git init "$PSScriptRoot"
}

try {
    # Make sure we're in the right directory.
    Push-Location $PSScriptRoot

    Write-Host
    Write-Host -ForegroundColor Cyan 'Adding skeleton files...'

    # IMPORTANT: We need to use "." here instead of "*" or hidden dot files won't be added
    #   on Linux.
    & git add .

    if ($KeepGitCleanFiles) {
        # Make sure the file is executable on Linux/macOS
        & git add --chmod=+x git-clean.sh
    }

    & git commit -m 'Added repository skeleton'

    Write-Host
    Write-Host -ForegroundColor Cyan 'Adding style guide files...'

    & git submodule add https://github.com/skrysmanski/AppMotor.StyleGuide.git _StyleGuide/

    & git commit -m 'Added style guide submodule'
}
finally {
    Pop-Location
}

Write-Host
Write-Host -ForegroundColor Green 'Done'
