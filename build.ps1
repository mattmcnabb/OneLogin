[CmdletBinding()]
param
(
    # a credential whose password is the PS Gallery API key
    [PSCredential]
    $Credential
)

try
{
    $path = $PSScriptRoot
    Write-Verbose 'Importing PowerShellGet and PlatyPS modules...'
    Import-Module PowerShellGet -ErrorAction Stop
    Import-Module PlatyPS

    $temp = Join-Path $env:temp "$([guid]::NewGuid().Guid)\OneLogin"
    $null = New-Item -Path $temp -ItemType Directory -ErrorAction Stop

    Write-Verbose "Copying release files to temporary folder '$temp'..."
    Copy-Item $path\OneLogin.ps?1 $temp\ -ErrorAction Stop
    Copy-Item $path\classes.cs    $temp\ -ErrorAction Stop
    Copy-Item $path\license       $temp\ -ErrorAction Stop
    Copy-Item $path\functions     $temp\ -Recurse -ErrorAction Stop
    Copy-Item $path\helpers       $temp\ -Recurse -ErrorAction Stop
    Copy-Item $path\formats       $temp\ -Recurse -ErrorAction Stop

    Write-Verbose 'Copy complete.  Contents:'
    Get-ChildItem $temp -Recurse | Out-Host

    Write-Verbose "Generating XML help..."
    New-Item -ItemType Directory -Name en-US -Path $Temp\ -ErrorAction Stop
    New-ExternalHelp -Path $path\md-help -OutPutPath $temp\OneLogin.xml -ErrorAction Stop

    Write-Verbose 'Publishing module to PowerShellGet...'
    Publish-Module -Path $temp -NuGetApiKey ($Credential.GetNetworkCredential().Password) -Confirm:$false -ErrorAction Stop
}
catch
{
    Write-Error -ErrorRecord $_
    exit 1
}
finally
{
    if ($temp)
    {
        Write-Verbose 'Cleaning up temporary folder...'
        Remove-Item -LiteralPath $temp -ErrorAction Ignore -Recurse -Force
    }
}
