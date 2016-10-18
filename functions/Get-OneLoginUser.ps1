function Get-OneLoginUser
{
    [CmdletBinding(DefaultParameterSetName = "Filter")]
    [OutputType([OneLogin.User])]
    param
    (
        [CmdletBinding(DefaultParameterSetName = "Filter")]
        [ValidateScript(
            {
                $Property = $_.GetEnumerator().Name
                $EnumValues = [OneLogin.UserFilterParameters].GetEnumNames()
                if ($Property -cin $EnumValues) { $true }
                else
                {
                    throw "[$Property] is not a filterable property. Filterable properties are [$($EnumValues -join ', ')]. These properties are CASE-SENSITIVE!"
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
    
    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    Invoke-OneLoginRestMethod @Splat | ForEach-Object { if ($_) {$_ -as $OutputType} }
}
