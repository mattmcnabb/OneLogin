---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginUserApp

## SYNOPSIS
Lists the OneLogin applications that a user has been granted access to.

## DESCRIPTION
Use Add-OneLoginUserRole to add one or more roles to a OneLoginLists the OneLogin applications that a user has been granted access to. These can be provisioned or personal applications and will include those provided manually or via roles and mappings.

## PARAMETERS
### Identity
Specifies the OneLogin user whose apps you'd like to query.

## EXAMPLES
### --------------  Example 1  --------------

```powershell
PS C:\> Get-OneLoginUser -Identity 12345678 | Get-OneLoginUserApp
```
This example shows how to retrieve all the applications granted to a OneLogin user.

### --------------  Example 2  --------------

```powershell
PS C:\> Get-OneLoginUser -Filter @{email = "Ronald*"} | Get-OneLoginUserApp
```
This example shows how to retrieve all the applications granted to any OneLogin user whose email address begins with "Ronald". 

## INPUTS
### OneLoginUser

## OUTPUTS
### OneLoginApp

## NOTES

## RELATED LINKS
[OneLogin user apps](https://developers.onelogin.com/api-docs/1/users/get-apps-for-user)