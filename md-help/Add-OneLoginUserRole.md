# Add-OneLoginUserRole

## SYNOPSIS
Adds a role to a OneLogin user

## DESCRIPTION
Use Add-OneLoginUserRole to add one or more roles to a OneLogin user. To discover roles to add, use the Get-OneLoginRole command, and to find roles that the user already belongs to, use Get-OneLoginUserRole.

## PARAMETERS
### Identity
Specifies the OneLogin user that you'd like to add a role to.

### RoleId
Specifies the Id of the role you'd like to add.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> $Role = Get-OneLoginRole -Filter @{name = "Sales"}
PS C:\> Get-OneLoginUser -Identity 12345678 | Add-OneLoginUserRole -RoleId $Role.id -Token $Token
```
This example demonstrates how to add a role to a user via the pipeline. Get-OneLoginUser returns a user by Id, and Add-OneLoginUserRole adds the role "Sales" to that user.

## INPUTS
### OneLoginUser
