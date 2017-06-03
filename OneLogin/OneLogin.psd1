@{
    NestedModules = @("OneLogin.psm1")
    ModuleVersion = "0.1.0"
    GUID = "87e0e33a-1747-4ff2-a812-890565b4f0d1"
    Author = "Matt McNabb"
    Copyright = "(c) 2016 . All rights reserved."
    Description = "A PowerShell module for automating components of a OneLogin account."
    PowerShellVersion = "5.0"
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
            Tags = "OneLogin","REST","IAM","Identity"
            LicenseUri   = "https://github.com/mattmcnabb/OneLogin/blob/master/OneLogin/license"
            ProjectUri = "https://github.com/mattmcnabb/OneLogin"
            ReleaseNotes = @"

v1.0.7
Features
- added the ability to filter for users by last name
Bug fixes
- some objects might not be returned if unexpected properties were returned from the REST API - fixed
- *Token commands should not have a default value for -Token parameter - fixed

v1.0.6
Bug fixes
- If you use the -WhatIf parameter with impactful commands (remove,set,add), the typename of the user object is returned instead of the user id - fixed
- Get-OneLoginUserRole and Get-OneLoginUserGroup sometimes returned incorrect data if you pipe the user object in via a variable - fixed

v1.0.5
Bug Fixes
- Filter parameters for Get-OneLoginEvent/Role/User don"t accept multiple filter properties
- Filter parameters for Get-OneLoginEvent/Role/User accept null values
"@
        }
    }

    # HelpInfo URI of this module
    # HelpInfoURI = ""
}
