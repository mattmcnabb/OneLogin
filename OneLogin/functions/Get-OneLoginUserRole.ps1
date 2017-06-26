function Get-OneLoginUserRole
{
    [CmdletBinding()]
    [OutputType([OneLogin.Role])]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity
    )

    process
    {
        $Identity = Get-OneLoginUser -Identity $Identity.id
        foreach ($RoleId in $Identity.role_id)
        {
            Get-OneLoginRole -Identity $RoleId
        }
    }
}
