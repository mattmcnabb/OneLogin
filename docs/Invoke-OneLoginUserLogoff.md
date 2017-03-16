---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Invoke-OneLoginUserLogoff

## SYNOPSIS
Logs a user out of OneLogin

## DESCRIPTION
Logs a user out of any active OneLogin sessions and any applications provided via OneLogin.

## PARAMETERS
### Identity
Specifies the user who will be logged off.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Invoke-OneLoginUserLogoff -Token $Token
```

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
