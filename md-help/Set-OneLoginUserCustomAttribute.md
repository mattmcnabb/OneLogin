# Set-OneLoginUserCustomAttribute

## SYNOPSIS
Sets the value of custom attributes.

## DESCRIPTION
Sets or modifies the value of custom attributes for a OneLogin user. Can also be used to add a custom attribute for a user.

## PARAMETERS
###Identity
Specifies a OneLogin user who you'd like to modify.

### CustomAttributes
Specifies the custom attributes and their values that will be applied to the user. The value of this parameter argument should be in the form of a PowerShell hashtable, with the key representing the name of the custom attribute, and the value being the custom attribute's value.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Set-OneLoginUserCustomAttribute -CustomAttributes @{employeeType = "Contractor"} Engineering -Token $Token
```

This example shows howto modify the value of the employeeType custom attribute for a user.

## INPUTS
### OneLoginUser
