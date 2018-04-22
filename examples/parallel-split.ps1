#Requires -Version 5
#Requires -module xpoTools
#Requires -module SplitPipeline

# To install the modules from https://www.powershellgallery.com/ run powershell commands:
# PS> Install-Module xpoTools
# PS> install-Module SplitPipeline
#
# see https://github.com/mazzy-ax/xpoTools and https://github.com/nightroman/SplitPipeline for details

Set-StrictMode -Version Latest

$load = 0 # 0 is auto. Try 10, 50, 100 or another values for a big xpo file.
$projectRoot = Resolve-Path $PSScriptRoot\..

# split
Get-ChildItem $projectRoot\tests\assets -filter '*.xpo' | 
    Import-Xpo |
    Split-Pipeline -Verbose -Load $load {process {
        Split-xpo -Destination $projectRoot\.test -xpp -PathStyle mazzy -Encoding UTF8 -PassThru
    }}

