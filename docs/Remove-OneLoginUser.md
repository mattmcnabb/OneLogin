---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Remove-OneLoginUser

## SYNOPSIS
Removes a user from your OneLogin account.

## DESCRIPTION
Removes a user from your OneLogin account.

## PARAMETERS
###Identity
Specifies a OneLogin user you'd like to remove.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUser -Token $Token
```

This example shows how to remove a OneLogin user. Note that you'll be prompted to confirm that you'd like to take this action.

### --------------  Example 2  --------------

```powershell
Get-OneLoginUser -Identity 123456 -Token $Token | Remove-OneLoginUser -Confirm:$false -Token $Token
```

This example shows how to remove a OneLogin user without being prompted for confirmation.

## INPUTS
### OneLoginUser

## OUTPUTS

## NOTES

## RELATED LINKS
