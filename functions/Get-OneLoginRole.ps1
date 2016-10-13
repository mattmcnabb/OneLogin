function Get-OneLoginRole
{
    [CmdletBinding(DefaultParameterSetName = "Filter")]
    [OutputType([OneLogin.Role])]
    param
    (
        [Parameter(ParameterSetName = "Filter")]
        [ValidateScript(
            {
                $Property = $_.GetEnumerator().Name
                $EnumValues = [OneLogin.RoleParameters].GetEnumValues()
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

        [Parameter(ParameterSetName = "Identity", Mandatory)]
        [int]
        $Identity,

        [Parameter(ParameterSetName = "All")]
        [switch]
        $All,

        [ValidateNotNullOrEmpty()]
        [OneLogin.Token]
        $Token
    )
    
    $Splat = @{
        Token    = $Token
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

    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    Invoke-OneLoginRestMethod @Splat | Foreach-Object { if ($_) {$_ -as $OutputType} }
}
