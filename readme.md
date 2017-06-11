[![Build status](https://ci.appveyor.com/api/projects/status/dktthvk43gwicc7l/branch/v2Tests?svg=true)](https://ci.appveyor.com/project/mattmcnabb/OneLogin)

# OneLogin Module for PowerShell

## Description
OneLogin is a cloud identity and access management application. This PowerShell module was created to interact with OneLogin's REST API to assist in automating identity management needs. This project has no affiliation with OneLogin, Inc.

## Requirements
PowerShell v5.0 or greater

### Note
While this module has only been tested on PowerShell v5.0, support for downlevel versions may be added when more testing is in place.

## Getting Started
### Install and import the module
In a PowerShell console run `Install-Module OneLogin` and confirm that you'd like to install the module. Once installed, you can import the module by running `Import-Module OneLogin`.

### Generate a OneLogin API credential pair
In order to make calls against the OneLogin REST API, you'll need to generate a credential pair in the OneLogin admin portal. Instructions for this can be found [here](https://developers.onelogin.com/api-docs/1/getting-started/working-with-api-credentials).

### Authorize calls to the REST API
Once you have a credential pair, you're ready to start using the OneLogin module. First, run the New-OneLoginToken command and pass it the API credential. Use the client key as the username, and the client secret as the password:

```powershell
$OLCred = Get-Credential
New-OneLoginToken -Credential $OLCred -Region us -SetAsDefault
```

### Start automating your OneLogin account
Now that you've generated an access token, you can start running commands against your OneLogin account. Start by checking out your users:

```powershell
Get-OneLoginUser -Filter @{email = "matt*"}
```

You can find other commands to explore and manage groups, roles, events and more by running `Get-Command -Module OneLogin`. Happy scripting!

## Special Thanks
- June Blender for helping me with an XML help issue
- Stephen Owen for helping out with a couple of REST/HTTP questions
- Joel Bennett for help with v5.0 classes
- Dave Wyatt for supporting this project on the PowerShell community build server
