function New-ConnectionMock
{
    [PSCustomObject]@{
        data = [PSCustomObject]@{
            access_token = "1234567890"
            created_at = (Get-Date).GetDateTimeFormats()[102]
            expires_in = 36000
            refresh_token = "1234567890"
            token_type = "bearer"
            account_id = "12345"
        }
    }
}

function New-PSCredentialMock
{
    [pscredential]::new("OLUser", (ConvertTo-SecureString '12345678' -AsPlainText -Force))
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

    $MyInvocation.MyCommand.ParameterSets.Parameters |
        Where-Object Position -eq -2147483648 |
        Select-Object -ExpandProperty Name
}

function New-ApiRateLimitMock
{
    [PSCustomObject]@{
        "X-RateLimit-Limit" = 5000
        "X-RateLimit-Remaining" = 4000
        "X-RateLimit-Reset" = 1622
    }
}