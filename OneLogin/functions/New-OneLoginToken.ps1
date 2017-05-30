function New-OneLoginToken
{
    [CmdletBinding()]
    [OutputType([OneLogin.Token])]
    param
    (
        [Parameter(Mandatory)]
        [System.Management.Automation.Credential()]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory)]
        [OneLogin.AdminRegions]
        $Region,

        [switch]
        $SetAsDefault
    )
    
    $ID         = $Credential.UserName
    $Secret     = $Credential.GetNetworkCredential().Password
    $ApiBase    = "https://api.$Region.onelogin.com"
    $Endpoint   = "auth/oauth2/token"
    $AuthHeader = @{ Authorization = "client_id:$ID, client_secret:$Secret" }

    $Body = @{ grant_type = "client_credentials" } | ConvertTo-Json
    
    $Splat = @{
        Uri         = "$ApiBase/$EndPoint"
        Headers     = $AuthHeader
        Body        = $Body
        Method      = 'Post'
        ContentType = 'application/json'
    }

    $Token = [OneLogin.Token](
        Invoke-RestMethod @Splat | Select-Object -ExpandProperty Data
    )
    $Token.ApiBase = $ApiBase
    
    $Token
    
    if ($SetAsDefault) { Set-OneLoginDefaultToken -Token $Token }
}
