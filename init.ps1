#!/usr/bin/env pwsh

Remove-Item "$PSScriptRoot/.git" -Recurse -Force
Remove-Item "$PSScriptRoot/README.md"
Remove-Item "$PSScriptRoot/init.ps1"

& git init "$PSScriptRoot"
