---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginRole

## SYNOPSIS
Retrieves roles from a OneLogin account.

## DESCRIPTION
Retrieves roles from a OneLogin account.

## PARAMETERS
### Filter
You can use the -Filter parameter to search for roles matching values that you specify. A filter should be in the format of a PowerShell hashtable with one or more properties as keys. Note that the filter values should always be strings, and can contain asterisks as wildcards. Acceptable properties to filter on are:

- name
- id

To learn more about hashtables, run the following command:

Get-Help about_hash_tables

This parameter cannot be used with -Identity r -All

### Identity
Specifies the numeric id of a OneLogin role.

### All
Specifies tthat you would like to return all roles in your OneLogin account. This parameter cannot be used with -Filter or -Identity.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginRole -All
```

This example returns all roles in the OneLogin account.

### --------------  Example 2  --------------

```powershell
Get-OneLoginRole -Identity 19848683
```

This example demonstrates how to use the -Identity parameter to return a single role object.

## INPUTS

## OUTPUTS
### OneLoginRole

## NOTES

## RELATED LINKS
