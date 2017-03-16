---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# New-OneLoginUser

## SYNOPSIS
Creates a new user in your OneLogin account.

## DESCRIPTION
Logs a user out of any active OneLogin sessions and any applications provided via OneLogin.

## PARAMETERS
###firstname
###lastname
###email
###username
###company
###department
###directory_id
###distinguished_name
###external_id
###group_id
###invalid_login_attempts
###locale_code
###manager_ad_id
###member_of
###notes
###openid_name
###phone
###samaccountname
###title
###userprincipalname

### Token
A OneLogin API access token that provides authorization for a OneLogin account. To generate an access token, use the New-OneLoginToken command.

## EXAMPLES

### --------------  Example 1  --------------
```powershell
New-OneLoginUser -firstname George -lastname Washington -email George.Washington@onelogin.com -username geowash -Token $Token
```

This example shows how to create a new OneLogin user.

## INPUTS

## OUTPUTS
### OneLoginUser

## NOTES

## RELATED LINKS
