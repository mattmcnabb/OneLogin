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
            Invoke-OneLoginRestMethod @Splat | Foreach-Object { [OneLogin.App[]]$_ }
        }
        catch [System.Management.Automation.PSInvalidCastException]
        {
            # API may be outputting undocumented object properties
            # check the text of the exception message to see what values are included in the typecast
            Write-Error $_ -ErrorAction Stop
        }
        catch
        {
            Write-Error $_
        }
    }
}