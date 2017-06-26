function Invoke-OneLoginUserLockout
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity,

        [int]
        $IntervalInMinutes = 0
    )
    
    begin
    {

        $Splat = @{
            Method = "Put"
            Body   = @{locked_until = $IntervalInMinutes}
        }
    }

    process
    {
        $Splat["Endpoint"] = "api/1/users/$($Identity.id)/lock_user"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}
