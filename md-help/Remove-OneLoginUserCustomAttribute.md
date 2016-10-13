# Remove-OneLoginUserCustomAttribute

## SYNOPSIS
Removes a custom attribute from a OneLogin user.

## DESCRIPTION
Removes a custom attribute from a OneLogin user.

## PARAMETERS
###Identity
Specifies a OneLogin user who you'd like to modify.

### CustomAttributes
Specifies one or more custom attributes to remove. You can find a user's custom attributes with the Get-OneLoginUser command, and you can find all available custom attributes in your account with Get-OneLoginCustomAttribute.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUserCustomAttribute -CustomAttributes employeeType -Token $Token
```

This example shows how to remove a custom attribute for a OneLogin user. Note that you'll be prompted to confirm that you'd like to take this action.

### --------------  Example 2  --------------
```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUserCustomAttribute -CustomAttributes employeeType -Token $Token
```

This example shows how to remove a custom attribute from a OneLogin user without being prompted for confirmation.

## INPUTS
### OneLoginUser
