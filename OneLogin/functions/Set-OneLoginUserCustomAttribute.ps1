function Set-OneLoginUserCustomAttribute
{
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory = $true)]
        [ValidateScript(
            {
                $_.GetEnumerator() | Foreach-Object {
                    $Name = $_.Name
                    $Value = $_.Value
                    if ([string]::IsNullOrEmpty($Value))
                    {
                        throw "One or more attributes has no value. Please specify a value for each custom attribute."
                    }
                    elseif ($Name -notin (Get-OneLoginCustomAttribute))
                    {
                        throw "Could not find a custom attribute with name '$Name'. To find custom attribute names, run 'Get-OneLoginCustomAttribute'."
                    }
                    else { $true }
                }
            }
        )]
        [hashtable]
        $CustomAttributes
    )
    
    begin
    {
        $Splat = @{
            Method = "Put"
            Body   = @{custom_attributes = $CustomAttributes}
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
