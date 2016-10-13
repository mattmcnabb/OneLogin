function Get-OneLoginEvent
{
    [CmdletBinding()]
    [OutputType([OneLogin.Event])]
    param
    (
        [ValidateScript(
            {
                $Property = $_.GetEnumerator().Name
                $EnumValues = [OneLogin.EventParameters].GetEnumValues()
                if ($Property -in $EnumValues) { $true }
                else
                {
                    throw "[$Property] is not a filterable property. Filterable properties are [$($EnumValues -join ', ')]"
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

    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    Invoke-OneLoginRestMethod @Splat |
        Foreach-Object {
            if ($_) { [OneLogin.Event]$_ }
        }
}
