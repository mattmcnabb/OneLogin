function Get-OneLoginCustomAttribute
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
    )
    
    $Splat = @{
        Endpoint = "api/1/users/custom_attributes"
    }
    
    Invoke-OneLoginRestMethod @Splat | Foreach-Object { $_ }
}
