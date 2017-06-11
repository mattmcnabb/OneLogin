$ProjectPath = Split-Path $PSScriptRoot
$ModuleName = Split-Path $ProjectPath -Leaf
$ModulePath = Join-Path $ProjectPath $ModuleName
$MocksPath = Join-Path $PSScriptRoot "mocks"
Import-Module $ModulePath -Force
Import-Module $MocksPath -Force

Describe "Get-BoundParameter" {
    InModuleScope -ModuleName $ModuleName {
        $Bound = New-BoundParameter
        $Common = Get-CommonParameter

        It "removes common parameters" {
            (Get-BoundParameter -BoundParameters $Bound).GetEnumerator() | Where-Object { $_.Name -in $Common } |
                Should Be $null
        }

        It "removes excluded parameters" {
            (Get-BoundParameter -BoundParameters $Bound -ExcludedParameters "Param2").GetEnumerator().Name |
                Should Be "Param1"
        }
    }
}
