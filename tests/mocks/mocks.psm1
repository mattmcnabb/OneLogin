function New-UserMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        activated_at           = (Get-Date).ToString("O")
        company                = $null
        created_at             = (Get-Date).ToString("O")
        custom_attributes      = $null
        department             = "Sales"
        directory_id           = 187552
        distinguished_name     = $null
        email                  = "OneLogin.User@domain.com"
        external_id            = $null
        firstname              = "OneLogin"
        group_id               = 54321
        id                     = 12345
        invalid_login_attempts = $null
        invitation_sent_at     = $null
        lastname               = "User"
        last_login             = (Get-Date).ToString("O")
        locale_code            = "en-US"
        locked_until           = $null
        manager_ad_id          = $null
        member_of              = $null
        notes                  = $null
        openid_name            = $null 
        password_changed_at    = $null
        phone                  = $null
        role_id                = "11234", "98237", "40725"
        samaccountname         = "ouser"
        state                  = "OH"
        status                 = 1
        title                  = "Sales Engineer"
        updated_at             = (Get-Date).ToString("O")
        username               = "ouser"
        userprincipalname      = "OneLogin.User@domain.com"
        
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-RoleMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        name = "Sales"
        id   = 86442
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-EventMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        account_id              = "12345"
        actor_system            = $null
        actor_user_id           = "23456"
        actor_user_name         = "ouser"
        app_id                  = $null
        app_name                = $null
        assuming_acting_user_id = $null
        client_id               = "12345"
        created_at              = (Get-Date).ToString("O")
        custom_message          = $null
        directory_sync_run_id   = $null
        directory_id            = "1"
        error_description       = $null
        event_type_id           = "202"
        group_id                = $null
        group_name              = $null
        id                      = "1192885978"
        ipaddr                  = $null
        notes                   = $null
        operation_name          = $null
        otp_device_id           = $null
        otp_device_name         = $null
        policy_name             = "Sales"
        policy_id               = "12345"
        proxy_ip                = $null
        resolution              = $null
        resource_type_id        = $null
        role_id                 = $null
        role_name               = $null
        user_id                 = "12345"
        user_name               = "ouser"
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-GroupMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        name      = "Engineering"
        id        = 13579
        reference = $null
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-AppMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        extension   = $false
        icon        = $null
        name        = "Pong"
        id          = 11223
        login_id    = $null
        personal    = $false
        provisioned = $false
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-ConnectionMock
{
    param
    (
        [switch]
        $InvalidProperties
    )

    $Object = [PSCustomObject]@{
        Data = [PSCustomObject]@{
            access_token  = "1234567890"
            created_at    = (Get-Date).ToString("O")
            expires_in    = 36000
            refresh_token = "1234567890"
            token_type    = "bearer"
            account_id    = "12345"
        }
    }

    If ($InvalidProperties)
    {
        $Object.Data | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function New-PSCredentialMock
{
    [pscredential]::new("OLUser", (ConvertTo-SecureString '12345678' -AsPlainText -Force))
}

function New-CustomAttributeMock
{
    @("Attribute1", "Attribute2")
}

function New-BoundParameter
{
    @{
        Param1              = "Value1"
        Param2              = "Value2"
        Verbose             = $true
        Debug               = $true
        ErrorAction         = "Continue"
        WarningAction       = "Continue"
        InformationAction   = "Continue"
        ErrorVariable       = "E"
        WarningVariable     = "W"
        InformationVariable = "I"
        OutVariable         = "O"
        OutBuffer           = $true
        PipelineVariable    = "P"
    }
}

function Get-CommonParameter
{
    [CmdletBinding()]
    param()

    [System.Management.Automation.Cmdlet]::CommonParameters
}

function New-ApiRateLimitMock
{
    [PSCustomObject]@{
        "X-RateLimit-Limit"     = 5000
        "X-RateLimit-Remaining" = 4000
        "X-RateLimit-Reset"     = 1622
    }

    If ($InvalidProperties)
    {
        $Object | Add-Member -MemberType NoteProperty -Name Invalid -Value "Invalid"
    }

    $Object
}

function Get-CommandMetadata
{
    param
    (
        [string]
        $CommandName
    )

    $Command = Get-Command $CommandName
    $Metadata = [System.Management.Automation.CommandMetadata]$Command
    $Metadata
}

function Test-TerminatingError
{
    param
    (
        [scriptblock]
        $ScriptBlock
    )
    try
    {
        & $ScriptBlock 2>&1 >> $null
        $false
    }
    catch
    {
        $true
    }
}

function New-RestMock
{
    param
    (
        [switch]
        $Link
    )

    $Output = [ordered]@{
        Status = [PSCustomObject]@{}
        Pagination = [PSCustomObject]@{
            before_cursor = "YWNjb3VudF9pZDo6Oi0tIyNpZDo6OjIzODc3NzU3"
            after_cursor  = "YWNjb3VudF9pZDo6Oi0tIyNpZDo6OjIzODc4OTQ3"
            previous_link = "https://api.us.onelogin.com/api/1/users?before_cursor=YWNjb3VudF9pZDo6Oi0tIyNpZDo6OjIzODc3NzU3"
            next_link     = "https://api.us.onelogin.com/api/1/users?after_cursor=YWNjb3VudF9pZDo6Oi0tIyNpZDo6OjIzODc4OTQ3"
        }
        Data = 1..50 | ForEach-Object {[PSCustomObject]@{Property = "whatev"}}
    }

    if (!$Link)
    {
        $Output.Pagination.after_cursor = $null
    }

    $Output
}
