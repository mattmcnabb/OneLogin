function Remove-OneLoginUserCustomAttribute
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory = $true)]
        [ValidateScript(
            {
                $_ | Foreach-Object {
                    if ($_ -notin (Get-OneLoginCustomAttribute))
                    {
                        throw "Could not find a custom attribute with name '$_'. To find custom attribute names, run 'Get-OneLoginCustomAttribute'."
                    }
                    else { $true }
                }
            }
        )]
        [string[]]
        $CustomAttributes
    )
    
    begin
    {
        $CustomAttributes = Get-OneLoginCustomAttribute | Where-Object {$_ -in $CustomAttributes}
        $Body = @{ custom_attributes = @{} }
        foreach ($Attribute in $CustomAttributes)
        {
            $Body["custom_attributes"][$Attribute] = [string]::Empty
        }
        $Splat = @{
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
