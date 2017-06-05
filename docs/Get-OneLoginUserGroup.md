---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginUserGroup

## SYNOPSIS
Returns the OneLogin group that a user is a member of.

## DESCRIPTION
Returns the OneLogin group that a user is a member of. A user can only belong to one group, and this group membership determines which security policy the user is subject to.

##PARAMETERS
### Identity
Specifies the user whose group membership you'd like to discover.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 123456 | Get-OneLoginUserGroup
```

This example shows how to retrieve the group membership for a single user.

### --------------  Example 2  --------------
```powershell
PS C:\> Get-OneLoginUser -Filter @{email = "George*"} | Get-OneLoginUserGroup
```

This example shows how to retrieve the group membership for multiple users.

## INPUTS
### OneLoginUser

## OUTPUTS
### OneLoginGroup

## NOTES

## RELATED LINKS
[OneLogin groups](https://developers.onelogin.com/api-docs/1/groups/get-groups)
