function New-OneLoginUser
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    [OutputType([OneLogin.User])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]
        $firstname,

        [Parameter(Mandatory = $true)]
        [string]
        $lastname,

        [Parameter(Mandatory = $true)]
        [string]
        $email,

        [Parameter(Mandatory = $true)]
        [string]
        $username,

        [string]
        $company,

        [string]
        $department,

        [string]
        $directory_id,

        [string]
        $distinguished_name,

        [string]
        $external_id,
        
        [string]
        $group_id,

        [int]
        $invalid_login_attempts,

        [string]
        $locale_code,

        [string]
        $manager_ad_id,

        [string]
        $member_of,

        [string]
        $notes,

        [string]
        $openid_name,

        [string]
        $phone,

        [string]
        $samaccountname,

        [string]
        $title,

        [string]
        $userprincipalname,

        [OneLogin.Token]
        $Token
    )
    
    $Body = Get-BoundParameter -BoundParameters $PSBoundParameters -ExcludedParameters Token

    $Splat = @{
        Token    = $Token
        Method   = "Post"
        Endpoint = "api/1/users"
        Body     = $Body
    }

    if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
    {
        [OneLogin.User](Invoke-OneLoginRestMethod @Splat)
    }
}
