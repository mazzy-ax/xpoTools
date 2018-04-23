$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

$script:manifest = $null

Describe 'Nuget specification  Tests' -Tag 'Meta' {

    It 'Passes Test-ModuleManifest' {
        $script:manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1
        $? | Should -Be $true
    }

    It 'has a valid nuspec file' {
        $file = Resolve-Path $projectRoot\$moduleName.nuspec
        [xml]$script:nuspec = Get-Content $file
        $nuspec | Should Not BeNullOrEmpty
    }

    It 'has a valid id' {
        $nuspec.package.metadata.id | Should Be ($moduleName)
    }

    It 'nuspec and manifest descriptions are same' {
        $nuspec.package.metadata.Description | Should Be ($manifest.Description)
    }

    It 'nuspec and manifest release notes are same' {
        $nuspecReleaseNotes = $nuspec.package.metadata.ReleaseNotes -replace '\s'
        $manifestReleaseNotes = $manifest.PrivateData.PSData.ReleaseNotes -replace '\s'
        
        $nuspecReleaseNotes -eq $manifestReleaseNotes | Should Be $true
    }

    It 'nuspec and manifest projectUrl are same' {
        $nuspec.package.metadata.projectUrl | Should Be ($manifest.PrivateData.PSData.ProjectUri)
    }

    It 'nuspec and manifest licenseUrl notes are same' {
        $nuspec.package.metadata.licenseUrl | Should Be ($manifest.PrivateData.PSData.LicenseUri)
    }

}