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

    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
    {
        $Token = Invoke-RestMethod @Splat |
        Select-Object -ExpandProperty Data |
        Select-Object account_id,
                      created_at,
                      expires_in,
                      token_type,
                      access_token,
                      refresh_token,
                      @{
                          Label = "ApiBase"
                          Expression = {$Token.ApiBase}
                       } | Foreach-Object { if ($_) {$_ -as $OutputType} }
                       
        $Token
        if ($SetAsDefault) { Set-OneLoginDefaultToken -Token $Token }
    }
}
