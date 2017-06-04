---
external help file: OneLogin-help.xml
online version: 
schema: 2.0.0
---

# Get-OneLoginEvent

## SYNOPSIS
Retrieves events from a OneLogin account

## DESCRIPTION
Retrieves events such as logins, role assignments, and password resets from a OneLogin account.

## PARAMETERS
### Filter
Specifies a combination of event properties to filter on. The filter should be in the form of a hashtable with one or more property names as keys. Note that the filter values should always be strings, and can contain asterisks as wildcards. Acceptable keys are:

- client_id
- created_at
- directory_id
- event_type_id
- resolution
- user_id

Valid values for event_type_id are available in the enum "OneLogin.EventType." To find out how to use this enum to find the event id integer values, see the examples for this help topic by running: Get-Help -Name Get-OneLoginEvent -Examples

More information about possible event types can be found at https://developers.onelogin.com/api-docs/1/events/event-resource.

To learn more about hashtables, run the command:

Get-Help about_hash_tables

### Since
The earliest date for which to return events. This can be used with or without a filter. If you don't specify a filter, the -Since parameter will be required.

### Until
The latest date for which to return events. If you specify the -Since parameter but not the -Until parameter, this will have a value of the current date and time.


## EXAMPLES
### --------------  Example 1  --------------

```powershell
Get-OneLoginEvent -Filter @{user_id = '112764'}
```

This example shows how to use a filter to return all events for a specific user, identified by the user_id property.

### --------------  Example 2  --------------

```powershell
Get-OneLoginEvent -Filter @{user_id = '112764'; event_type_id = '11'}
```

This example shows how to retrieve events for a specific user and specific event type, a password change.

### --------------  Example 3  --------------

```powershell
Get-OneLoginEvent -Filter @{user_id = '112764'} -Since "9/23/2016" -Until "9/24/2016"
```

This example will return all events for a specific user that occured between 9/23/2016 and 9/24/2016.

### --------------  Example 4  --------------

```powershell
Get-OneLoginEvent -Since "9/23/2016" -Until "9/24/2016"
```

This example will retrieve all events of any type between 9/23/2016 and 9/24/2016

### --------------  Example 5  --------------

```powershell
Get-OneLoginEvent -Filter @{event_type_id = [int][OneLogin.EventType]::User_logged_in_to_app}
```

This example will retrieve all events of type 'User_logged_in_to_app. Note the use of the enum "OneLogin.EventType" to calculate the numerical event id.

## INPUTS

## OUTPUTS
### OneLoginEvent

## NOTES

## RELATED LINKS
