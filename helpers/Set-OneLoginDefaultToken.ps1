function Set-OneLoginDefaultToken
{
    param
    (
        [OneLogin.Token]
        $Token
    )

    $ModuleName = $PSCmdlet.MyInvocation.MyCommand.Module.Name
    $Module = Get-Module -Name $ModuleName
    $Commands = $Module.ExportedCommands.GetEnumerator()  | Select-Object -ExpandProperty value | Select-Object -ExpandProperty name
    foreach ($Command in $Commands)
    {
        $Global:PSDefaultParameterValues["$Command`:Token"] = $Token
    }
}
