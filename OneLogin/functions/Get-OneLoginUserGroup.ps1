function Get-OneLoginUserGroup
{
    [CmdletBinding()]
    [OutputType([OneLogin.Group])]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        [OneLogin.User]
        $Identity
    )
    
    process
    {
        $Identity = Get-OneLoginUser -Identity $Identity.id
        foreach ($Id in $Identity.group_id)
        {
            Get-OneLoginGroup -Identity $Id
        }
    }
}