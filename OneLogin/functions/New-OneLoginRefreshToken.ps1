function New-OneLoginRefreshToken
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    [OutputType([OneLogin.Token])]
    param
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [OneLogin.Token]
        $Token,

        [switch]
        $SetAsDefault
    )
    
    $Uri = "$($Token.ApiBase)/auth/oauth2/token"

    $Body = @{
        grant_type = "refresh_token"
        access_token = $Token.access_token
        refresh_token = $Token.refresh_token
    } | ConvertTo-Json
    
    $Splat = @{
        Uri         = $Uri
        Body        = $Body
        Method      = 'Post'
        ContentType = 'application/json'
    }

    if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
    {
        $RefreshToken = [OneLogin.Token](
            Invoke-RestMethod @Splat | Select-Object -ExpandProperty Data
        )
        $RefreshToken.ApiBase = $Token.ApiBase

        $RefreshToken
        
        if ($SetAsDefault) { Set-OneLoginDefaultToken -Token $RefreshToken }
    }
}
