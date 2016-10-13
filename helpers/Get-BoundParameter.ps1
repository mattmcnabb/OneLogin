function Get-BoundParameter
{
    <#
        .Description
        returns bound parameters excluding common parameters and any others explicitly excluded
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [hashtable]
        $BoundParameters,

        [string[]]
        $ExcludedParameters
    )

    $CommonParameters = $MyInvocation.MyCommand.ParameterSets.Parameters | Where-Object Position -eq -2147483648 | Select-Object -ExpandProperty Name
    $ToExclude = $CommonParameters + $ExcludedParameters
    $Hash = @{}
    $BoundParameters.GetEnumerator() | Foreach {
        if ($_.Name -notin $ToExclude) { $Hash.Add($_.Name, $_.Value) }
    }

    $Hash
}
