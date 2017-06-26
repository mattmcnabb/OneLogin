function Invoke-OneLoginUserLogoff
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity
    )
    
    begin
    {
        $Splat = @{
            Method = "Put"
        }
    }

    process
    {
        $Splat["Endpoint"] = "api/1/users/$($Identity.id)/logout"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}
