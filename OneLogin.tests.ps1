$ModulePath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModuleName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

$ManifestPath   = "$ModulePath\$ModuleName.psd1"
if (Get-Module -Name $ModuleName) { Remove-Module $ModuleName -Force }
Import-Module $ManifestPath

# test the module manifest - exports the right functions, processes the right formats, and is generally correct
Pester\Describe "Manifest" {
    
    $ManifestHash = Invoke-Expression (Get-Content $ManifestPath -Raw)

    Pester\It "has a valid manifest" {
        {
            $null = Test-ModuleManifest -Path $ManifestPath -ErrorAction Stop -WarningAction SilentlyContinue
        } | Pester\Should Not Throw
    }

    Pester\It "has a valid root module" {
        $ManifestHash.NestedModules | Pester\Should Be "$ModuleName.psm1"
    }

    Pester\It "has a valid Description" {
        $ManifestHash.Description | Pester\Should Not BeNullOrEmpty
    }

    Pester\It "has a valid guid" {
        $ManifestHash.Guid | Pester\Should Be "87e0e33a-1747-4ff2-a812-890565b4f0d1"
    }

    Pester\It "has a valid version" {
        $ManifestHash.ModuleVersion -as [Version] | Pester\Should Not BeNullOrEmpty
    }

    Pester\It "has a valid copyright" {
        $ManifestHash.CopyRight | Pester\Should Not BeNullOrEmpty
    }

    Pester\It 'processes all existing format files' {
        $FormatFiles = Get-ChildItem "$ModulePath\formats\" -Filter *.ps1xml | Select-Object -ExpandProperty fullname
        $ExportedFormats = $ManifestHash.FormatsToProcess | foreach {"$ModulePath\$_"}
        $ExportedFormats | Pester\Should Be $FormatFiles
    }
    
    Pester\It 'has a valid license Uri' {
        $ManifestHash.PrivateData.Values.LicenseUri | Pester\Should Be 'http://opensource.org/licenses/MIT'
    }
    
    Pester\It 'has a valid project Uri' {
        $ManifestHash.PrivateData.Values.ProjectUri | Pester\Should Be 'https://github.com/mattmcnabb/OneLogin'
    }

    Pester\It "gallery tags don't contain spaces" {
        foreach ($Tag in $ManifestHash.PrivateData.Values.tags)
        {
            $Tag | Pester\Should Not Match '\s'
        }
    }
}

Describe "Functions" {
    InModuleScope -ModuleName $ModuleName {
        Pester\Context "Get-BoundParameter" {
            $BoundParameters = @{
                Param1              = "Value1"
                Param2              = "Value2"
                Verbose             = $true
                Debug               = $true
                ErrorAction         = "Continue"
                WarningAction       = "Continue"
                InformationAction   = "Continue"
                ErrorVariable       = "E"
                WarningVariable     = "W"
                InformationVariable = "I"
                OutVariable         = "O"
                OutBuffer           = $true
                PipelineVariable    = "P"

            }

            $Common = @(
                "Verbose",
                "Debug",
                "ErrorAction",
                "WarningAction",
                "InformationAction",
                "ErrorVariable",
                "WarningVariable",
                "InformationVariable",
                "OutVariable",
                "OutBuffer",
                "PipelineVariable"
            )

            Pester\It "removes common parameters" {
                (Get-BoundParameter -BoundParameters $BoundParameters).GetEnumerator() | Where-Object {
                    $_.Name -in $Common
                }  | Pester\Should Be $null
            }

            Pester\It "removes excluded parameters" {
                $Bound = (Get-BoundParameter -BoundParameters $BoundParameters -ExcludedParameters "Param2").GetEnumerator()
                $Bound.Name | Pester\Should Be "Param1"

            }
        }

        Pester\Context "Get-OneLoginEvent" {
            # make sure you can pass multiple filter properties
            Pester\It "accepts multiple filter properties" {
                Pester\Mock -CommandName Invoke-RestMethod -MockWith {[PSCustomObject]@{}}
                $Token = [OneLogin.Token]::new()
                { Get-OneLoginEvent -Filter @{user_id = "123456"; directory_id = "56789" } -Token $Token} | Pester\Should Not Throw
            }
        }

        Pester\Context "Get-OneLoginUser" {
            # make sure you can pass multiple filter properties
            Pester\It "accepts multiple filter properties" {
                Pester\Mock -CommandName Invoke-RestMethod -MockWith {[PSCustomObject]@{}}
                $Token = [OneLogin.Token]::new()
                { Get-OneLoginUser -Filter @{firstname = "Matt"; email = "matt@domain.com" } -Token $Token} | Pester\Should Not Throw
            }
        }
    }
}
