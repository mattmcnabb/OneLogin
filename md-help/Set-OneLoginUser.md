# Set-OneLoginUser

## SYNOPSIS
Sets attributes of a OneLogin user.

## DESCRIPTION
Sets or modifies attributes of an existing OneLogin user.

## PARAMETERS
###Identity
Specifies a OneLogin user who you'd like to modify.
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
Get-OneLoginUser -Identity 123456 -Token $Token | Set-OneLoginUser -department Engineering -Token $Token
```

This example shows howto modify the department attribute for a OneLogin user.

## INPUTS
### OneLoginUser
