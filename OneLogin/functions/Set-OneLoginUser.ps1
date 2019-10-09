function Set-OneLoginUser
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [OneLogin.User]
        $Identity,

        [string]
        $company,

        [string]
        $department,

        [string]
        $directory_id,

        [string]
        $distinguished_name,

        [string]
        $email,

        [string]
        $external_id,

        [string]
        $firstname,

        [string]
        $group_id,

        [string]
        $invalid_login_attempts,

        [string]
        $lastname,

        [string]
        $locale_code,

        [string]
        $manager_ad_id,

        [string]
        $member_of,

        [string[]]
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
        $username,

        [string]
        $userprincipalname,

        [int]
        $state,

        [int]
        $status
    )

    begin
    {
        $Body = Get-BoundParameter -BoundParameters $PSBoundParameters -ExcludedParameters Identity

        $Splat = @{
            Method = "Put"
            Body   = $Body
        }
    }

    process
    {
        $Splat["Endpoint"] = "api/1/users/$($Identity.Id)"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}
