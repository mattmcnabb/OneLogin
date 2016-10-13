# New-OneLoginToken

## SYNOPSIS
Refreshes a OneLogin API access token that is nearing expiration

## DESCRIPTION
Refreshes a OneLogin API access token that is nearing expiration. These tokens are passed to other commands in the OneLogin module.

In order to authenticate to the OneLogin API, you must first grant access by generating a credential pair in the OneLogin web interface. To generate an API credential, log in to your OneLogin tenant with an admin account and navigate to "Settings" > "API" and click "New Credential." Please note that your choice of credential type will affect what capabilities you are granted by the API.

Issued tokens are valid for 10 hours. Once you have been issued a refresh token, the original token is revoked and will no longer authenticate calls to the OneLogin API.

## PARAMETERS

### Token
The administrative region that your account exists in. Valid values are "us" and "eu."

### SetAsDefault
Specifies whether you'd like to set this token as the default value for the -Token parameter of all OneLogin commands. If you select this option, any subsequent OneLogin commands will use this token without the need to specify the -Token parameter. Please note that this modifies the value of the automatic variable $PSDefaultParameterValues in your current PowerShell session.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS c:\> $Credential = Get-Credential
PS c:\> $Token = New-OneLoginToken -Credential $Credential -Region us
PS c:\> $Token = New-OneLoginRefreshToken -Token $Token
```
This example demonstrates how to generate a OneLogin token and then refresh that token. 

### --------------  Example 2  --------------

```powershell
PS c:\> New-OneLoginRefreshToken -Token $Token -SetAsDefault
```
This example demonstrates how to refresh an existing OneLogin token and set it as the default token value for subsequent calls to OneLogin commands. This is recommended if you originally created the token using the -SetAsDefault switch.

## OUTPUTS
### OneLoginToken
