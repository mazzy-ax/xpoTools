$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

$ExcludeRules = @(
    'PSUseShouldProcessForStateChangingFunctions'
)

Describe "PSScriptAnalyzer Rules for $moduleName" -Tag Meta, BestPractice, BP {
    $analysis = Invoke-ScriptAnalyzer -Path $projectRoot -ExcludeRule $ExcludeRules -Recurse
    $analysis | Out-Default

    It "Should have no failures" {
        $analysis.Count | Should -Be 0
    }

}