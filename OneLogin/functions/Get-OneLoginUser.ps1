function Get-OneLoginUser
{
    [CmdletBinding(DefaultParameterSetName = "Filter")]
    [OutputType([OneLogin.User])]
    param
    (
        [CmdletBinding(DefaultParameterSetName = "Filter")]
        [ValidateScript(
            {
                $EnumValues = [OneLogin.UserFilterParameter].GetEnumNames()
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

        [Parameter(ParameterSetName = "Identity", Mandatory)]
        [int]
        $Identity,

        [Parameter(ParameterSetName = "All")]
        [switch]
        $All,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [OneLogin.Token]
        $Token
    )
    
    $Splat = @{
        Token    = $Token
        Method   = "Get"
        Endpoint = "api/1/users"
    }
    
    switch ($PSCmdlet.ParameterSetName)
    {
        "Filter"
        {
            if (!$PSBoundParameters.ContainsKey("Filter"))
            {
                throw "A filter is required. If you'd like to return all objects, please specify the -All switch parameter."
            }
            $Splat.Body = $Filter
        }
        "Identity" { $Splat.Body = @{id = $Identity} }
    }
    
    try
    {
        [OneLogin.User[]](Invoke-OneLoginRestMethod @Splat)
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
