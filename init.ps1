#!/usr/bin/env pwsh

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

Write-Host
Write-Host -ForegroundColor Cyan 'Initializing new Git repository...'
$gitVersion = & git version
if ($gitVersion -ge 'git version 2.28.0') {
    & git init --initial-branch=main "$PSScriptRoot"
}
else {
    & git init "$PSScriptRoot"
}

Write-Host
Write-Host -ForegroundColor Cyan 'Adding skeleton files...'
& git add *
& git commit -m 'Added repository skeleton'

if (-Not ([System.Environment]::OSVersion.Platform -ne 'Win32NT')) {
    & chmod +x "$PSScriptRoot/git-clean.sh"
}

Write-Host
Write-Host -ForegroundColor Green 'Done'
