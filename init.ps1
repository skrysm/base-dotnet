#!/usr/bin/env pwsh
param(
    [Parameter(Mandatory=$True)]
    [string] $SolutionName,

    [string] $KeepGitCleanFiles = 'yes',

    [string] $KeepGitCloneSubmodulesFiles = 'yes'
)

# Stop on every error
$script:ErrorActionPreference = 'Stop'

# NOTE: The cast to [bool] is required (to change the type of $KeepGitCleanFiles
#   which is declared as string above).
[bool] $KeepGitCleanFiles = switch ($KeepGitCleanFiles) {
    'yes'    { $true }
    'true'   { $true }
    '$true'  { $true }

    'no'     { $false }
    'false'  { $false }
    '$false' { $false }

    default { Write-Error "Invalid input: $KeepGitCleanFiles" }
}

# NOTE: The cast to [bool] is required (to change the type of $KeepGitCloneSubmodulesFiles
#   which is declared as string above).
[bool] $KeepGitCloneSubmodulesFiles = switch ($KeepGitCloneSubmodulesFiles) {
    'yes'    { $true }
    'true'   { $true }
    '$true'  { $true }

    'no'     { $false }
    'false'  { $false }
    '$false' { $false }

    default { Write-Error "Invalid input: $KeepGitCloneSubmodulesFiles" }
}

$SolutionName = $SolutionName.TrimEnd('.sln')

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

Write-Host -ForegroundColor Cyan 'Removing "_ProjectCommons/"...'
Remove-Item "$PSScriptRoot/_ProjectCommons" -Recurse -Force

if (-Not $KeepGitCleanFiles) {
    Remove-Item "$PSScriptRoot/git-clean.cmd"
    Remove-Item "$PSScriptRoot/git-clean.sh"
}

if (-Not $KeepGitCloneSubmodulesFiles) {
    Remove-Item "$PSScriptRoot/git-clone-submodules.cmd"
    Remove-Item "$PSScriptRoot/git-clone-submodules.sh"
}

Write-Host -ForegroundColor Cyan 'Removing "_keep.txt" files...'
Remove-Item "$PSScriptRoot/*/_keep.txt" -Recurse -Force

Write-Host -ForegroundColor Cyan 'Removing ".git"...'
Remove-Item "$PSScriptRoot/.git" -Recurse -Force

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
    if ($KeepGitCloneSubmodulesFiles) {
        # Make sure the file is executable on Linux/macOS
        & git add --chmod=+x git-clone-submodules.sh
    }

    & git commit -m 'Add repository skeleton'

    Write-Host
    Write-Host -ForegroundColor Cyan 'Adding project commons...'

    & git submodule add https://github.com/skrysmanski/DotNetProjectCommons.git _ProjectCommons

    & git commit -m 'Add project commons submodule'
}
finally {
    Pop-Location
}

Write-Host
Write-Host -ForegroundColor Green 'Done'
