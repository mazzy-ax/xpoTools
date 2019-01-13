$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

$changelog = "$projectRoot\CHANGELOG.md"
$manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1

Describe 'Changelog tests' -Tag Meta {

    It 'has a valid changelog file' {
        $changelog | Should -Exist
    }

    It "has version on the top of the Changelog and the version is equal to manifest version" {
        $changelog | Should -FileContentMatch "(?!=(\d+\.){1,3}\d+)$($manifest.Version)"
    }

}
