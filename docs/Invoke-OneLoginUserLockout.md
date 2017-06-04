---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Invoke-OneLoginUserLockout

## SYNOPSIS
Locks out a OneLogin user for a specified period of time.

## DESCRIPTION
Locks out a OneLogin user for a specified period of time. While locked out, the user will not be able to sign in to OneLogin or provided applications.

##PARAMETERS
### Identity
Specifies the user who will be locked out.

### IntervalInMinutes
Specifies the duration in minutes that the user will be locked out. If you do not specify a value, or if you specify zero, the lockout duration will be the value of the lockout duration in the user's security policy. If the user's security policy does not specify a lockout duration, and the value of -IntervalInMinutes is 0 or unspecified, the lockout will remain in effect until you unlock the user.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 123456 | Invoke-OneLoginUserLockout -IntervalInMinutes 60
```

This example demonstrates how to lock out a user for one hour.

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
