function Remove-OneLoginUserCustomAttribute
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory = $true)]
        [string[]]
        $CustomAttributes,

        [Parameter(Mandatory = $true)]
        [OneLogin.Token]
        $Token
    )
    
    begin
    {
        $CustomAttributes = Get-OneLoginCustomAttribute -Token $Token | Where {$_ -in $CustomAttributes}
        $Body = @{ custom_attributes = @{} }
        foreach ($Attribute in $CustomAttributes)
        {
            $Body["custom_attributes"][$Attribute] = [string]::Empty
        }
        $Splat = @{
            Token  = $Token
            Method = "Put"
            Body   = $Body
        }
    }
    
    process
    {
        $Splat["Endpoint"] = "api/1/users/$($Identity.Id)/set_custom_attributes"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}
