#!/usr/bin/env pwsh

Write-Host 'Removing ".git"...'
Remove-Item "$PSScriptRoot/.git" -Recurse -Force

Write-Host 'Removing "README.md"...'
Remove-Item "$PSScriptRoot/README.md"

Write-Host 'Removing "init.ps1"...'
Remove-Item "$PSScriptRoot/init.ps1"

Write-Host 'Initializing new Git repository...'
& git init "$PSScriptRoot"

Write-Host 'Adding skeleton files...'
& git add *
& git commit -m 'Added repository skeleton'

Write-Host
Write-Host -ForegroundColor Green 'Done'
