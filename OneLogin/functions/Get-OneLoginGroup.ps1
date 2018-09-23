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
        $OutputType = $PSCmdlet.MyInvocation.MyCommand.OutputType.Type
        (Invoke-OneLoginRestMethod @Splat) | ConvertTo-OneLoginObject -OutputType $OutputType
    }
    catch
    {
        Write-Error $_
    }
}
