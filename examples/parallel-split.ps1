
# To install modules from https://www.powershellgallery.com/packages/xpoTools run powershell commands:
# PS> Install-Module xpoTools
# PS> install-Module SplitPipeline
#
# see https://github.com/mazzy-ax/xpoTools and https://github.com/nightroman/SplitPipeline for details

$load = 0 # auto. Try 10, 50, 100 or another values for a big xpo file.

$projectRoot = (Resolve-Path $PSScriptRoot\..).Path
$data = @{
    projectRoot = $projectRoot
}

Write-Verbose 'parallel split'
Get-ChildItem $projectRoot\tests\assets\*.xpo |
    Import-Xpo |
    Split-Pipeline -Verbose -Load $load -Variable data -Module xpoTools {process {

        Split-xpo -Items $_ -Destination $data.projectRoot, .test -xpp -PathStyle mazzy -Encoding UTF8 -PassThru
    }
}
