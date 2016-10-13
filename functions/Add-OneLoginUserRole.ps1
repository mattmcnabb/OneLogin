function Add-OneLoginUserRole
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory = $true)]
        [int[]]
        $RoleId,

        [Parameter(Mandatory = $true)]
        [OneLogin.Token]
        $Token
    )
    
    begin
    {
        $Splat = @{
            Token    = $Token
            Method   = "Put"
            Body     = @{role_id_array = @($RoleId)}
        }
    }
    
    process
    {
        $Splat["Endpoint"] = "api/1/users/$($Identity.id)/add_roles"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}