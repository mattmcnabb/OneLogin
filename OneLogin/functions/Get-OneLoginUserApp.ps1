function Get-OneLoginUserApp
{
    [CmdletBinding()]
    [OutputType([OneLogin.App])]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity,

        [Parameter(Mandatory)]
        [OneLogin.Token]
        $Token
    )
    
    process
    {
        $Splat = @{
            Token    = $Token
            Endpoint = "api/1/users/$($Identity.id)/apps"
        }

        try
        {
            [OneLogin.App[]](Invoke-OneLoginRestMethod @Splat)
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