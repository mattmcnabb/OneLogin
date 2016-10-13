# Get-OneLoginCustomAttribute
 
## SYNOPSIS
Returns all custom attribute names configured in a OneLogin account.

## DESCRIPTION
Returns all custom attribute names configured in a OneLogin account. Values for custom attributes are not returned - these are returned by the command Get-OneLoginUserCustomAttribute.

## PARAMETERS
### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginCustomAttribute -Token $Token
```
This example will return the names of all custom attributes configured in your OneLogin account.

## OUTPUTS
### System.String
