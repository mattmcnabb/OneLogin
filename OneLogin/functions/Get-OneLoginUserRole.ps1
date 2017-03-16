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
        $Identity = Get-OneLoginUser -Identity $Identity.id -Token $Token
        foreach ($RoleId in $Identity.role_id)
        {
            Get-OneLoginRole -Identity $RoleId -Token $Token
        }
    }
}
