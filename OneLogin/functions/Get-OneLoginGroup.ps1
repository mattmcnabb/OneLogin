function Get-OneLoginGroup
{
    [CmdletBinding()]
    [OutputType([OneLogin.Group])]
    param
    (
        [int]
        $Identity
    )
    
    $Splat = @{
        Endpoint = "api/1/groups"
    }

    if ($Identity) { $Splat["Body"] = @{id = $Identity} }

    try
    {
        Invoke-OneLoginRestMethod @Splat | ForEach-Object { [OneLogin.Group[]]$_ }
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
