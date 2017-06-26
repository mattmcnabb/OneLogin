---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Remove-OneLoginUserRole

## SYNOPSIS
Removes a role from a OneLogin user.

## DESCRIPTION
Removes a role from a OneLogin user.

## PARAMETERS
###Identity
Specifies a OneLogin user who you'd like to modify.

### RoleId
Specifies one or more roles that you'd like to remove by their numerical Id. These Ids can be found using the Get-OneLoginRole command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
$Role = Get-OneLoginRole -Filter @{name = "Sales"}
Get-OneLoginUser -Identity 123456 | Remove-OneLoginUserRole -RoleId $Role.Id
```

This example shows how to find a OneLogin role and remove that role from a user's list of assigned roles. Note that you'll be prompted to confirm that you'd like to take this action.

### --------------  Example 2  --------------

```powershell
Get-OneLoginUser -Identity 123456 | Remove-OneLoginUserRole -RoleId $Role.Id -Confirm:$false
```

This example shows how to remove a role from a OneLogin user without being prompted for confirmation.

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
[OneLogin roles](https://developers.onelogin.com/api-docs/1/roles/get-roles)
[OneLogin user roles](https://developers.onelogin.com/api-docs/1/users/get-roles-for-user)
