function Get-OneLoginApiRateLimit
{
    [CmdletBinding()]
    [OutputType([OneLogin.ApiRateLimit])]
    param
    (
    )
    
    $Splat = @{
        Endpoint = "auth/rate_limit"
    }
    
    Invoke-OneLoginRestMethod @Splat | Foreach-Object {
        [OneLogin.ApiRateLimit]::new($_."X-RateLimit-Limit", $_."X-RateLimit-Remaining", $_."X-RateLimit-Reset")
    }
}