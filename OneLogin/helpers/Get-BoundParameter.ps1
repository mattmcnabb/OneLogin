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

    $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters
    $ToExclude = $CommonParameters + $ExcludedParameters
    $Hash = @{}
    $BoundParameters.GetEnumerator() | ForEach-Object {
        if ($_.Name -notin $ToExclude) { $Hash.Add($_.Name, $_.Value) }
    }

    $Hash
}
