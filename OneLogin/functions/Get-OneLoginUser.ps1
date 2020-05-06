function Get-OneLoginUser
{
    [CmdletBinding(DefaultParameterSetName = "All")]
    [OutputType([OneLogin.User])]
    param
    (
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
        [Parameter(ParameterSetName = 'Filter')]
        [hashtable]
        $Filter,

        [Parameter(ParameterSetName = "Identity", Mandatory)]
        [int]
        $Identity,

        [Parameter(ParameterSetName = "All")]
        [switch]
        $All
    )
    
    $Splat = @{
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
        $OutputType = $PSCmdlet.MyInvocation.MyCommand.OutputType.Type
        (Invoke-OneLoginRestMethod @Splat) | ConvertTo-OneLoginObject -OutputType $OutputType
    }
    catch
    {
        Write-Error $_
    }
}
