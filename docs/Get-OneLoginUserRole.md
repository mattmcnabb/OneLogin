---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginUserRole

## SYNOPSIS
Returns the OneLogin roles that have been assigned to a user.

## DESCRIPTION
Returns the OneLogin roles that have been assigned to a user. These roles may be assigned automatically via mappings, or manually assigned by an administrator.

##PARAMETERS
### Identity
Specifies the user whose role assignments you'd like to discover.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 123456 | Get-OneLoginUserRole
```

This example shows how to retrieve the role assignments for a single user.

### --------------  Example 2  --------------
```powershell
PS C:\> Get-OneLoginUser -Filter @{email = "George*"} | Get-OneLoginUserRole
```

This example shows how to retrieve the role assignments for multiple users.

## INPUTS
### OneLoginUser

## OUTPUTS
### OneLoginRole

## NOTES

## RELATED LINKS
[OneLogin roles](https://developers.onelogin.com/api-docs/1/roles/get-roles)
[OneLogin user roles](https://developers.onelogin.com/api-docs/1/users/get-roles-for-user)
