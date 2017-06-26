$ProjectPath = Split-Path $PSScriptRoot

if ($env:APPVEYOR)
{
    $ModuleName = $env:Appveyor_Project_Name
    $Version = $env:APPVEYOR_BUILD_VERSION
}
else
{
    $ModuleName = Split-Path $ProjectPath -Leaf
    $Version = "0.1.0"
}

$ModulePath = Join-Path $ProjectPath $ModuleName
$ManifestPath = Join-Path $ModulePath "$ModuleName.psd1"
if (Get-Module -Name $ModuleName) { Remove-Module $ModuleName -Force }
Import-Module $ManifestPath -Force

Describe 'PSScriptAnalyzer' {
    It "passes Invoke-ScriptAnalyzer" {
        $AnalyzeSplat = @{
            Path        = $ModulePath
            ExcludeRule = "PSUseDeclaredVarsMoreThanAssignments"
            Severity    = "Warning"
        }
        Invoke-ScriptAnalyzer @AnalyzeSplat | Should be $null
    }
}

Describe "Docs" {
    It "help file exists" {
        $DocsPath = Join-Path $ModulePath "en-US"
        $Doc = Join-Path $DocsPath "$ModuleName-help.xml"
        Test-Path $Doc | Should Be $true
    }
}

# test the module manifest - exports the right functions, processes the right formats, and is generally correct
Describe "Manifest" {
    $Content = Get-Content -Path $ManifestPath -Raw
    $SB = [scriptblock]::Create($Content)
    $ManifestHash = & $SB

    It "has a valid manifest" {
        {
            $null = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Should Not Throw
    }

    It "has a valid nested module" {
        $ManifestHash.NestedModules | Should Be "$ModuleName.psm1"
    }

    It "has a valid Description" {
        $ManifestHash.Description | Should Not BeNullOrEmpty
    }

    It "has a valid guid" {
        $ManifestHash.Guid | Should Be "87e0e33a-1747-4ff2-a812-890565b4f0d1"
    }

    It "has a valid version" {
        $ManifestHash.ModuleVersion | Should Be $Version
    }

    It "has a valid copyright" {
        $ManifestHash.CopyRight | Should Not BeNullOrEmpty
    }

    It 'exports all public functions' {
        $FunctionFiles = Get-ChildItem "$ModulePath\functions" -Filter *.ps1 | Select-Object -ExpandProperty basename
        $FunctionNames = $FunctionFiles
        Compare-Object $ManifestHash.FunctionsToExport $FunctionNames | Should BeNullOrEmpty
    }
    
    It 'has a valid license Uri' {
        $ManifestHash.PrivateData.Values.LicenseUri | Should Be "https://github.com/mattmcnabb/OneLogin/blob/master/OneLogin/license"
    }
    
    It 'has a valid project Uri' {
        $ManifestHash.PrivateData.Values.ProjectUri | Should Be "https://github.com/mattmcnabb/OneLogin"
    }
    
    It "gallery tags don't contain spaces" {
        foreach ($Tag in $ManifestHash.PrivateData.Values.tags)
        {
            $Tag -notmatch '\s' | Should Be $true
        }
    }
}

