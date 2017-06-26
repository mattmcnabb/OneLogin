---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Connect-OneLogin

## SYNOPSIS
Connects to the OneLogin REST API

## DESCRIPTION
Connects to the OneLogin REST API other commands in the OneLogin module.

In order to authenticate to the OneLogin API, you must first grant access by generating a credential pair in the OneLogin web interface. To generate an API credential, log in to your OneLogin tenant with an admin account and navigate to "Settings" > "API" and click "New Credential." Please note that your choice of credential type will affect what capabilities you are granted by the API.

Issued tokens are valid for 10 hours. If your token expires, you can run Connect-OneLogin again to re-connect.

## PARAMETERS
### Credential
The OAuth client ID and client secret associated with a OneLogin API credential. Use the client ID as the username and the client secret as the password. Instructions for obtaining a credential pair can be found here: https://developers.onelogin.com/api-docs/1/getting-started/working-with-api-credentials

### Region
The administrative region that your account exists in. Valid values are "us" and "eu."

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS c:\> $Credential = Get-Credential
PS c:\> $Token = Connect-OneLogin -Credential $Credential -Region us
```
This example demonstrates how to save a credential object in a variable and pass that credential to Connect-OneLogin

### --------------  Example 2  --------------

```powershell
PS c:\> Remove-Module OneLogin
```
You can disconnect from the OneLogin service by simply removing the module

### --------------  Example 3  --------------

```powershell
PS c:\> Import-Module OneLogin -Force
```
You can also disconnect by forcing a re-import the OneLogin module

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
[OneLogin API credentials](https://developers.onelogin.com/api-docs/1/getting-started/working-with-api-credentials)
[Get-Credential command](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.security/get-credential)
