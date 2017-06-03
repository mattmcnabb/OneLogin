function Connect-OneLogin
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [System.Management.Automation.Credential()]
        [PSCredential]
        $Credential,

        [Parameter(Mandatory)]
        [OneLogin.AdminRegion]
        $Region
    )
    
    $ID = $Credential.UserName
    $Secret = $Credential.GetNetworkCredential().Password
    $ApiBase = "https://api.$Region.onelogin.com"
    $Endpoint = "auth/oauth2/token"
    $AuthHeader = @{ Authorization = "client_id:$ID, client_secret:$Secret" }

    $Body = @{ grant_type = "client_credentials" } | ConvertTo-Json
    
    $Splat = @{
        Uri         = "$ApiBase/$EndPoint"
        Headers     = $AuthHeader
        Body        = $Body
        Method      = 'Post'
        ContentType = 'application/json'
    }

    $Script:Token = [OneLogin.Token](
        Invoke-RestMethod @Splat | Select-Object -ExpandProperty Data
    )
    $Script:Token.ApiBase = $ApiBase
}
