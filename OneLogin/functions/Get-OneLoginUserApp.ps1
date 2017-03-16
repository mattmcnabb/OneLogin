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
    
        $OutputType = $MyInvocation.MyCommand.OutputType.Type
        Invoke-OneLoginRestMethod @Splat | Foreach-Object { if ($_) {$_ -as $OutputType} }       
    }
}