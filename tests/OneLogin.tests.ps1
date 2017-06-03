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
Import-Module $ModulePath -Force

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
                { Get-OneLoginEvent -Filter @{user_id = "123456"; directory_id = "56789" } } | Pester\Should Not Throw
            }
        }

        Pester\Context "Get-OneLoginUser" {
            # make sure you can pass multiple filter properties
            Pester\It "accepts multiple filter properties" {
                Pester\Mock -CommandName Invoke-RestMethod -MockWith {[PSCustomObject]@{}}
                { Get-OneLoginUser -Filter @{firstname = "Matt"; email = "matt@domain.com" } } | Pester\Should Not Throw
            }
        }
    }
}
