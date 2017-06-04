---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

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

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 | Remove-OneLoginUserCustomAttribute -CustomAttributes employeeType
```

This example shows how to remove a custom attribute for a OneLogin user. Note that you'll be prompted to confirm that you'd like to take this action.

### --------------  Example 2  --------------
```powershell
Get-OneLoginUser -Identity 123456 | Remove-OneLoginUserCustomAttribute -CustomAttributes employeeType
```

This example shows how to remove a custom attribute from a OneLogin user without being prompted for confirmation.

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
