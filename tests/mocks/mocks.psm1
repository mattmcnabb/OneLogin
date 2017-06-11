function New-UserMock
{
    [PSCustomObject]@{
        data = [PSCustomObject]@{
            activated_at           = (Get-Date).GetDateTimeFormats()[102]
            company                = $null
            created_at             = (Get-Date).GetDateTimeFormats()[102]
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
            last_login             = (Get-Date).GetDateTimeFormats()[102]
            locale_code            = "en-US"
            locked_until           = $null
            manager_ad_id          = $null
            member_of              = $null
            notes                  = $null
            openid_name            = $null 
            password_changed_at    = $null
            phone                  = $null
            role_id                = "Sales", "Developers", "Marketing"
            samaccountname         = "ouser"
            state                  = "OH"
            status                 = 1
            title                  = "Sales Engineer"
            updated_at             = (Get-Date).GetDateTimeFormats()[102]
            username               = "ouser"
            userprincipalname      = "OneLogin.User@domain.com"
        }
        
    }
}

function New-RoleMock
{
    [PSCustomObject]@{
        Data = [PSCustomObject]@{
            name = "Sales"
            id   = 86442
        }
    }
}

function New-GroupMock
{
    [PSCustomObject]@{
        Data = [PSCustomObject]@{
            name = "Engineering"
            id   = 13579
            reference = $null
        }
    }
}

function New-ConnectionMock
{
    [PSCustomObject]@{
        data = [PSCustomObject]@{
            access_token  = "1234567890"
            created_at    = (Get-Date).GetDateTimeFormats()[102]
            expires_in    = 36000
            refresh_token = "1234567890"
            token_type    = "bearer"
            account_id    = "12345"
        }
    }
}

function New-PSCredentialMock
{
    [pscredential]::new("OLUser", (ConvertTo-SecureString '12345678' -AsPlainText -Force))
}

function New-CustomAttributeMock
{
    [PSCustomObject]@{ Data = "Attribute1", "Attribute2" }
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
}