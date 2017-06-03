function Get-OneLoginEvent
{
    [CmdletBinding()]
    [OutputType([OneLogin.Event])]
    param
    (
        [ValidateScript(
            {
                $EnumValues = [OneLogin.EventFilterParameter].GetEnumNames()
                foreach ($Property in $_.GetEnumerator().Name)
                {
                    if ($Property -cin $EnumValues) { $true }
                    else
                    {
                        throw "[$Property] is not a filterable property. Filterable properties are [$($EnumValues -join ', ')]. These properties are CASE-SENSITIVE!"
                    }

                    if (!$_.$Property)
                    {
                        throw "Invalid filter value! The value specified for the filter property [$($_.$Property)] is null or empty."
                    }
                }
            }
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Filter,

        [DateTimeOffset]
        $Since,

        [DateTimeOffset]
        $Until = ([DateTimeOffset]::now),

        [ValidateNotNullOrEmpty()]
        [OneLogin.Token]
        $Token
    )



    $Splat = @{
        Token    = $Token
        Endpoint = "api/1/events"
        Body     = @{}
    }

    switch ($PSBoundParameters)
    {
        {$_.ContainsKey("Filter")}
        {
            $Splat["Body"] = $Filter
        }

        {$_.ContainsKey("Since")}
        {
            $Splat["Body"]["since"] = $Since.UtcDateTime.ToString("O")
            $Splat["Body"]["until"] = $Until.UtcDateTime.ToString("O")
        }
        Default
        {
            # validate parameters
            # Can use -Since and -Filter together or separately, but at least one is required
            throw "Get-OneLoginEvent: The command cannot be called without filtering parameters, or with only the -Until parameter. Please specify the -Filter parameter, the -Since parameter, or both."
        }
    }

    try
    {
        [OneLogin.Event[]](Invoke-OneLoginRestMethod @Splat)
    }
    catch [System.Management.Automation.PSInvalidCastException]
    {
        # API may be outputting undocumented object properties
        # check the text of the exception message to see what values are included in the typecast
        Write-Error $_ -ErrorAction Stop
    }
    catch
    {
        Write-Error $_
    }
}
