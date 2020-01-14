function Set-OneLoginUserPasswd
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $password,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $password_confirmation,

        [string]
        $validate_policy = $false
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
        $Splat["Endpoint"] = "api/1/users/set_password_clear_text/$($Identity.Id)"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}
