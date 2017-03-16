function Get-OneLoginCustomAttribute
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [ValidateNotNullOrEmpty()]
        [OneLogin.Token]
        $Token
    )
    
    $Splat = @{
        Token    = $Token
        Endpoint = "api/1/users/custom_attributes"
    }
    
    Invoke-OneLoginRestMethod @Splat
}
