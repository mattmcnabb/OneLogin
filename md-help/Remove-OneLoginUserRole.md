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

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
$Role = Get-OneLoginRole -Filter @{name = "Sales" -Token $Token}
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUserRole -RoleId $Role.Id -Token $Token
```

This example shows how to find a OneLogin role and remove that role from a user's list of assigned roles. Note that you'll be prompted to confirm that you'd like to take this action.

### --------------  Example 2  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUserRole -RoleId $Role.Id -Confirm:$false -Token $Token
```

This example shows how to remove a role from a OneLogin user without being prompted for confirmation.

## INPUTS
### OneLoginUser
