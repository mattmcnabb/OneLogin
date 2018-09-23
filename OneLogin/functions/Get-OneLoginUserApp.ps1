function Get-OneLoginUserApp
{
    [CmdletBinding()]
    [OutputType([OneLogin.App])]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity
    )
    
    process
    {
        $Splat = @{
            Endpoint = "api/1/users/$($Identity.id)/apps"
        }

        try
        {
            $OutputType = $PSCmdlet.MyInvocation.MyCommand.OutputType.Type
            (Invoke-OneLoginRestMethod @Splat) | ConvertTo-OneLoginObject -OutputType $OutputType
        }

        catch
        {
            Write-Error $_
        }
    }
}