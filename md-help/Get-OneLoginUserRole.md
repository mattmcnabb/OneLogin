# Get-OneLoginUserRole

## SYNOPSIS
Returns the OneLogin roles that have been assigned to a user.

## DESCRIPTION
Returns the OneLogin roles that have been assigned to a user. These roles may be assigned automatically via mappings, or manually assigned by an administrator.

##PARAMETERS
### Identity
Specifies the user whose role assignments you'd like to discover.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 123456 -Token $Token | Get-OneLoginUserRole -Token $Token
```

This example shows how to retrieve the role assignments for a single user.

### --------------  Example 2  --------------
```powershell
PS C:\> Get-OneLoginUser -Filter @{email = "George*"} -Token $Token | Get-OneLoginUserRole -Token $Token
```

This example shows how to retrieve the role assignments for multiple users.

## INPUTS
### OneLoginUser

## OUTPUTS
### OneLoginRole
