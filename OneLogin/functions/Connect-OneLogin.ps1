function Connect-OneLogin
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
        [OneLogin.AdminRegion]
        $Region
    )
    
    $ID = $Credential.UserName
    $Secret = $Credential.GetNetworkCredential().Password
    $ApiBase = "https://api.$Region.onelogin.com"
    $Endpoint = "auth/oauth2/token"
    $encodedAuthorization = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$ID`:$Secret"))
    $AuthHeader = @{ Authorization = "Basic $encodedAuthorization" }

    $Body = @{ grant_type = "client_credentials" } | ConvertTo-Json
    
    $Splat = @{
        Uri         = "$ApiBase/$EndPoint"
        Headers     = $AuthHeader
        Body        = $Body
        Method      = 'Post'
        ContentType = 'application/json'
    }

    $OutputType = $PSCmdlet.MyInvocation.MyCommand.OutputType.Type
    $Script:Token = Invoke-RestMethod @Splat |
        Select-Object -ExpandProperty Data |
        ConvertTo-OneLoginObject -OutputType $OutputType
    $Script:Token.ApiBase = $ApiBase
}
