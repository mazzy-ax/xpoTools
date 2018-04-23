$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

$assets = "$projectRoot\tests\assets"

#Import-Module $moduleRoot -Force

Describe "Basic function feature integration tests for module $moduleName" -Tags Build, Integration {

    Context "Import-Xpo" {
        $xpoItems = Get-ChildItem $assets -filter '*.xpo' | Import-Xpo -WarningAction SilentlyContinue

        It "Import-Xpo ok" {
            $xpoItems | Should -Not -Be $null
        }
    }

    Context "Split-Xpo" {
        $xpoItems = Get-ChildItem $assets -filter '*.xpo' | Import-Xpo -WarningAction SilentlyContinue

        It "Split-Xpo ok" {
            $Files = $xpoItems | Split-xpo -DestinationPathParts $TestDrive -xpp -PathStyle mazzy -Encoding UTF8 -PassThru
            $Files | Should -Not -Be $null
        }

        It "No overwrite is default" {
            $Files2 = $xpoItems | Split-xpo -DestinationPathParts $TestDrive -xpp -PathStyle mazzy -Encoding UTF8 -PassThru
            $Files2 | Should -Be $null
        }

        It "Switch on OverwriteNewer" {
            $Files2 = $xpoItems | Split-xpo -DestinationPathParts $TestDrive -xpp -PathStyle mazzy -Encoding UTF8 -PassThru -OverwriteNewer
            $Files2 | Should -Not -Be $null
        }
    }

    Context "Merge-Xpo" {
        $xpoItems = Get-ChildItem $assets -filter '*.xpo' | Import-Xpo -WarningAction SilentlyContinue
        $Files = $xpoItems | Split-xpo -DestinationPathParts $TestDrive -xpp -PathStyle mazzy -Encoding UTF8 -PassThru

        It "Merge-Xpo ok" {
            $destFile = "$TestDrive\merge.xpo"
            $files | Import-Xpo -WarningAction SilentlyContinue | Merge-Xpo -DestinationPath $destFile -WarningAction SilentlyContinue
            $destFile | Should -Exist
        }
    }
}