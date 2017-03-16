Add-Type -Path "$PSScriptRoot/classes.cs"

& {
    Get-ChildItem -Path "$PSScriptRoot\functions" -Exclude *tests.ps1
    Get-ChildItem -Path "$PSScriptRoot\helpers" -Exclude *tests.ps1
} | ForEach-Object { . $_.FullName }
