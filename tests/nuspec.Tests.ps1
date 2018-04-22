$projectRoot = Resolve-Path $PSScriptRoot\..
$moduleRoot = Split-Path (Resolve-Path $projectRoot\*\*.psd1)
$moduleName = Split-Path $moduleRoot -Leaf

$changelog = 'CHANGELOG.md'

Describe 'Module Manifest Tests' -Tag 'Meta' {

    It 'Passes Test-ModuleManifest' {
        $script:manifest = Test-ModuleManifest -Path $moduleRoot\$moduleName.psd1
        $? | Should -Be $true
    }

    It 'has a valid name in the manifest' {
        $manifest.Name | Should Be xpoTools
    }

    It 'has a valid guid in the manifest' {
        $manifest.Guid | Should Be '7d38f75a-76c4-466f-883b-fff39c2985c4'
    }

    It 'has a description in the manifest' {
        $manifest.Description | Should Not BeNullOrEmpty
    }

    It 'has release notes in the manifest' {
        $manifest.PrivateData.PSData.ReleaseNotes | Should Not BeNullOrEmpty
    }

    $publicFunctions = (Get-ChildItem -Path $moduleRoot\functions\*.ps1).baseName

    It 'has valid functions to export' {
        $manifest.ExportedFunctions.Keys | Should Be $publicFunctions
    }

    It 'has valid cmdlets to export' {
        $manifest.ExportedCmdlets.Keys | Should Be $publicFunctions
    }

    It 'has a valid version in the manifest' {
        $manifest.Version -as [Version] | Should Not BeNullOrEmpty
    }

    It "has a valid version on the top of $projectRoot\$changelog" {
        Get-Content -Path $projectRoot\$changelog |
            Where-Object { $_ -match '^\D*(?<Version>(\d+\.){1,3}\d+)' } | 
            Select-Object -First 1 | Should Not BeNullOrEmpty

        $script:ChangelogVersion = $matches.Version
        $ChangelogVersion                | Should Not BeNullOrEmpty
        $ChangelogVersion -as [Version]  | Should Not BeNullOrEmpty
    }

    It 'changelog and manifest versions are the same' {
        $manifest.Version -as [Version] | Should be ( $ChangelogVersion -as [Version] )
    }

}