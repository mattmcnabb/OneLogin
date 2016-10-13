# Get-OneLoginUserGroup

## SYNOPSIS
Returns the OneLogin group that a user is a member of.

## DESCRIPTION
Returns the OneLogin group that a user is a member of. A user can only belong to one group, and this group membership determines which security policy the user is subject to.

##PARAMETERS
### Identity
Specifies the user whose group membership you'd like to discover.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 123456 -Token $Token | Get-OneLoginUserGroup -Token $Token
```

This example shows how to retrieve the group membership for a single user.

### --------------  Example 2  --------------
```powershell
PS C:\> Get-OneLoginUser -Filter @{email = "George*"} -Token $Token | Get-OneLoginUserGroup -Token $Token
```

This example shows how to retrieve the group membership for multiple users.

## INPUTS
### OneLoginUser

## OUTPUTS
### OneLoginGroup
