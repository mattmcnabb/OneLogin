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

    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    $Token = Invoke-RestMethod @Splat |
        Select-Object -ExpandProperty Data |
        Select-Object account_id, created_at, expires_in,
                      token_type, access_token, refresh_token,
                      @{
                          Label = "ApiBase"
                          Expression = {$ApiBase}
                       } | Foreach-Object { if ($_) {$_ -as $OutputType} }
    
    $Token
    
    if ($SetAsDefault) { Set-OneLoginDefaultToken -Token $Token }
}
