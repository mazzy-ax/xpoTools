$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

$appveyor = "$projectRoot\appveyor.yml"
$manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1

Describe 'appveyor Tests' -Tag Meta {

    It 'has a valid appveyor file' {
        $appveyor | Should -Exist
    }

    It 'appveyor and manifest versions are same' {
        $appveyor | Should -FileContentMatch "version: $($manifest.Version).{build}"
    }

}
