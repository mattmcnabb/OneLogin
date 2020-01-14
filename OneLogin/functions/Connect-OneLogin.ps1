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

    # PS Core 6.2 headeer validation fix
    $PSDefaultParameterValues['Invoke-RestMethod:SkipHeaderValidation'] = $true

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

    $OutputType = $PSCmdlet.MyInvocation.MyCommand.OutputType.Type
    $Script:Token = Invoke-RestMethod @Splat |
        Select-Object -ExpandProperty Data |
        ConvertTo-OneLoginObject -OutputType $OutputType
    $Script:Token.ApiBase = $ApiBase
}
