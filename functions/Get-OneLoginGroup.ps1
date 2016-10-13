function Get-OneLoginGroup
{
    [CmdletBinding()]
    [OutputType([OneLogin.Group])]
    param
    (
        [int]
        $Identity,

        [Parameter(Mandatory)]
        [OneLogin.Token]
        $Token
    )
    
    $Splat = @{
        Token    = $Token
        Endpoint = "api/1/groups"
    }

    if ($Identity) { $Splat["Body"] = @{id = $Identity} }
    $OutputType = $MyInvocation.MyCommand.OutputType.Type
    Invoke-OneLoginRestMethod @Splat | Foreach-Object { if ($_) {$_ -as $OutputType} }
}
