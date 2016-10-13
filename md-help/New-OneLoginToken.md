# New-OneLoginToken

## SYNOPSIS
Generates a OneLogin API access token

## DESCRIPTION
Generates a OneLogin API access token that can be passed to other commands in the OneLogin module.

In order to authenticate to the OneLogin API, you must first grant access by generating a credential pair in the OneLogin web interface. To generate an API credential, log in to your OneLogin tenant with an admin account and navigate to "Settings" > "API" and click "New Credential." Please note that your choice of credential type will affect what capabilities you are granted by the API.

Issued tokens are valid for 10 hours. If you'd like to refresh a token that is near to its' expiration, use the New-OneLoginRefreshToken command.

## PARAMETERS
### Credential
The OAuth client ID and client secret associated with a OneLogin API credential. Use the client ID as the username and the client secret as the password. Instructions for obtaining a credential pair can be found here: https://developers.onelogin.com/api-docs/1/getting-started/working-with-api-credentials

### Region
The administrative region that your account exists in. Valid values are "us" and "eu."

### SetAsDefault
Specifies whether you'd like to set this token as the default value for the -Token parameter of all OneLogin commands. If you select this option, any subsequent OneLogin commands will use this token without the need to specify the -Token parameter. Please note that this modifies the value of the automatic variable $PSDefaultParameterValues in your current PowerShell session.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS c:\> $Credential = Get-Credential
PS c:\> $Token = New-OneLoginToken -Credential $Credential -Region us
```
This example demonstrates how to save a credential object in a variable and pass that credential to New-OneLoginToken

### --------------  Example 2  --------------

```powershell
PS c:\> $Credential = Get-Credential
PS c:\> New-OneLoginToken -Credential $Credential -Region us -SetAsDefault
```
In this example, we've created a OneLogin token and set it as the default token for all OneLogin commands. After this, the -Token parameter of the commands from the OneLogin module will not be required.

## OUTPUTS
### OneLoginToken
