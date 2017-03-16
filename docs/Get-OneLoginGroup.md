---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginGroup

## SYNOPSIS
Retrieves groups from a OneLogin account.

## DESCRIPTION
Retrieves groups from a OneLogin account. 

## PARAMETERS
### Identity
Specifies the numeric id of a OneLogin group. If you do not include this parameter, all available groups will be returned.

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.


## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginGroup -Token $Token
```

This example returns all groups in the OneLogin account.

### --------------  Example 2  --------------

```powershell
Get-OneLoginGroup -Identity 19848683 -Token $Token
```

This example demonstrates how to use the -Identity parameter to return a single group object.

## INPUTS

## OUTPUTS
### OneLoginGroup

## NOTES

## RELATED LINKS
