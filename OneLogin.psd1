@{
    NestedModules = @('OneLogin.psm1')
    ModuleVersion = '1.0.2'
    GUID = '87e0e33a-1747-4ff2-a812-890565b4f0d1'
    Author = 'Matt McNabb'
    Copyright = '(c) 2016 . All rights reserved.'
    Description = 'A PowerShell module for automating components of a OneLogin account.'
    PowerShellVersion = '5.0'
    FormatsToProcess = @(
        "formats\App.format.ps1xml",
        "formats\Event.format.ps1xml",
        "formats\Group.format.ps1xml",
        "formats\Role.format.ps1xml",
        "formats\Token.format.ps1xml",
        "formats\User.format.ps1xml"
    )
    FunctionsToExport = @(
        "Add-OneLoginUserRole",
        "Get-OneLoginCustomAttribute",
        "Get-OneLoginEvent",
        "Get-OneLoginGroup",
        "Get-OneLoginRole",
        "Get-OneLoginUser",
        "Get-OneLoginUserApp",
        "Get-OneLoginUserGroup",
        "Get-OneLoginUserRole",
        "Invoke-OneLoginUserLockout"
        "Invoke-OneLoginUserLogoff",
        "New-OneLoginRefreshToken",
        "New-OneLoginToken",
        "New-OneLoginUser",
        "Remove-OneLoginUser",
        "Remove-OneLoginUserCustomAttribute",
        "Remove-OneLoginUserRole",
        "Set-OneLoginUser",
        "Set-OneLoginUserCustomAttribute"
    )

    PrivateData = @{
        PSData = @{
            Tags = 'OneLogin','REST','IAM','Identity'
            LicenseUri = 'http://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/mattmcnabb/OneLogin'
            ReleaseNotes = @"
BUG FIXES
- Fixed: Get-OneLoginUser did not work - added new properties to users - company, department, title
- Fixed: formatting inconsistencies for date properties
"@
        }
    }

    # HelpInfo URI of this module
    # HelpInfoURI = ''
}
