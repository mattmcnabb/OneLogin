function Get-OneLoginUserRole
{
    [CmdletBinding()]
    [OutputType([OneLogin.Role])]
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
        foreach ($ID in $Identity.role_id)
        {
            Get-OneLoginRole -Identity $ID -Token $Token
        }
    }
}