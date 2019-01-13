$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

$manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1

Describe 'Module Manifest tests' -Tag Meta {
    It 'has a valid module manifest file' {
        $manifest | Should -Not -BeNullOrEmpty
    }

    It 'has a valid name in the manifest' {
        $manifest.Name | Should -Be $moduleName
    }

    It 'has a valid guid in the manifest' {
        $manifest.Guid -as [guid] | Should -Not -BeNullOrEmpty
    }

    It 'has a description in the manifest' {
        $manifest.Description | Should -Not -BeNullOrEmpty
    }

    It 'has release notes in the manifest' {
        $manifest.PrivateData.PSData.ReleaseNotes | Should -Not -BeNullOrEmpty
    }

    $publicFunctions = (Get-ChildItem -Path $moduleRoot\Functions\*.ps1).baseName

    It 'has valid functions to export' {
        $manifest.ExportedFunctions.Keys | Sort-Object | Should -Be $publicFunctions
    }

    It 'has a valid version in the manifest' {
        $manifest.Version -as [Version] | Should -Not -BeNullOrEmpty
    }

    It 'description have not back quote' {
        $manifest.Description | Should -Not -Match '`'
    }

    It 'release notes have not back quote' {
        $manifest.PrivateData.PSData.ReleaseNotes | Should -Not -Match '`'
    }

}