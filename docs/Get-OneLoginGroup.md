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

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginGroup
```

This example returns all groups in the OneLogin account.

### --------------  Example 2  --------------

```powershell
Get-OneLoginGroup -Identity 19848683
```

This example demonstrates how to use the -Identity parameter to return a single group object.

## INPUTS

## OUTPUTS
### OneLoginGroup

## NOTES

## RELATED LINKS
