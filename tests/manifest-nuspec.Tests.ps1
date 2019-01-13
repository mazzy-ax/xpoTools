$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

[xml]$nuspec = Get-Content $projectRoot\$moduleName.nuspec
$manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1

Describe 'Nuget specification tests' -Tag Meta {

    It 'has a valid nuspec file' {
        $nuspec | Should -Not -BeNullOrEmpty
    }

    It 'has a valid id' {
        $nuspec.package.metadata.id | Should -Be $moduleName
    }

    It 'nuspec and manifest versions are same' {
        $nuspec.package.metadata.version | Should -Be $manifest.Version
    }

    It 'nuspec and manifest descriptions are same' {
        $nuspec.package.metadata.description | Should -Be $manifest.Description
    }

    It 'nuspec and manifest release notes are same' {
        $nuspecReleaseNotes = $nuspec.package.metadata.releaseNotes -replace '\s'
        $manifestReleaseNotes = $manifest.PrivateData.PSData.ReleaseNotes -replace '\s'

        $nuspecReleaseNotes | Should -Be $manifestReleaseNotes
    }

    It 'nuspec and manifest projectUrl are same' {
        $nuspec.package.metadata.projectUrl | Should -Be $manifest.PrivateData.PSData.ProjectUri
    }

}
