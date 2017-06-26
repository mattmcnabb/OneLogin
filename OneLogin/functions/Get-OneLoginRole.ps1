function Get-OneLoginRole
{
    [CmdletBinding(DefaultParameterSetName = "Filter")]
    [OutputType([OneLogin.Role])]
    param
    (
        [Parameter(ParameterSetName = "Filter")]
        [ValidateScript(
            {
                $EnumValues = [OneLogin.RoleFilterParameter].GetEnumNames()
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
        $All
    )
    
    $Splat = @{
        Endpoint = "api/1/roles"
    }
    
    switch ($PSCmdlet.ParameterSetName)
    {
        "Filter"
        {
            if (!$PSBoundParameters.ContainsKey("Filter"))
            {
                throw "A filter is required. If you'd like to return all objects, please specify the -All switch parameter."
            }
            $Splat["Body"] = $Filter
        }
        "Identity" { $Splat["Body"] = @{id = $Identity} }
    }

    try
    {
        Invoke-OneLoginRestMethod @Splat | Foreach-Object { [OneLogin.Role[]]$_ }
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
