#Requires -Version 5
#Requires -module xpoTools

# To install the modules from https://www.powershellgallery.com/ run powershell commands:
# PS> Install-Module xpoTools
#
# see https://github.com/mazzy-ax/xpoTools for details

$projectRoot = Resolve-Path $PSScriptRoot\..

Write-Verbose 'Split'
Get-ChildItem $projectRoot\tests\assets -filter '*.xpo' | 
    Import-Xpo |
    Split-xpo -Destination $projectRoot\.test -xpp -PathStyle mazzy -Encoding UTF8 -PassThru

Write-Verbose 'Merge'
Get-ChildItem $projectRoot\.test\*.* -Recurse |
    Import-Xpo |
    Merge-Xpo -DestinationPath $projectRoot\.example-merge.xpo
