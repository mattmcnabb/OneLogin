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

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 | Invoke-OneLoginUserLogoff
```

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
[OneLogin user logoff](https://developers.onelogin.com/api-docs/1/users/log-user-out)