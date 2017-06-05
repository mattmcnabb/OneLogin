---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginUser

## SYNOPSIS
Retrieves users from a OneLogin account.

## DESCRIPTION
Retrieves users and their attributes from a OneLogin account.

## PARAMETERS
### Filter
You can use the -Filter parameter to search for users matching values that you specify. A filter should be in the format of a PowerShell hashtable with one or more properties as keys. Note that the filter values should always be strings, and can contain asterisks as wildcards. Acceptable properties to filter on are:

- directory_id
- email
- external_id
- firstname
- lastname
- manager_ad_id
- role_id
- samaccountname
- username
- userprincipalname

To learn more about hashtables, run the following command:

Get-Help about_hash_tables

This parameter cannot be used with -Identity or -All


### Identity
Specifies the numeric id of a OneLogin user.


### All
Specifies tthat you would like to return all roles in your OneLogin account. This parameter cannot be used with -Filter or -Identity.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginUser -All
```

This example returns all users in the OneLogin account.


### --------------  Example 2  --------------

```powershell
Get-OneLoginUser -Identity 123456
```

This example demonstrates how to use the -Identity parameter to return a single user object.


### --------------  Example 3  --------------

```powershell
Get-OneLoginUser -Filter @{email = "abraham.lincoln@onelogin.com"}
```

This example demonstrates how to use the -Filter parameter to return a single user by specifying an email address.


### --------------  Example 4  --------------

```powershell
Get-OneLoginUser -Filter @{email = "george.w*"}
```

This example demonstrates how to use the -Filter parameter to return any users whose email address matches a wildcard string.


### --------------  Example 5  --------------

```powershell
Get-OneLoginUser -Filter @{firstname = "george"; lastname = "wash*"}
```

This example demonstrates how to use the -Filter parameter with more than one property.

## INPUTS

## OUTPUTS
### OneLoginUser

## NOTES

## RELATED LINKS
[OneLogin users](https://developers.onelogin.com/api-docs/1/users/user-resource)
