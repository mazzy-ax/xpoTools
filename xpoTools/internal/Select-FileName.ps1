#Requires -Version 5
Set-StrictMode -Version Latest

function Select-FileName {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [xpoItem]$Item,
        [string[]]$PathParts,
        [string]$Ext = '.xpo',

        [ValidateSet('Default', 'mazzy', 'AOT', 'Flat', 'FlatAOT', 'FlatProject', 'Project', 'All')]
        [string]$PathStyle = 'Default',
        [scriptblock]$PathStyleScript
    )

    process {
        $funcName = $MyInvocation.InvocationName

        if ( -not $PathStyleScript ) {
            $PathStyleScript = Get-PathStyle -Style $PathStyle
        }

        $PathParts = $PathParts.Trim() -split '\s*[\\/]\s*'

        $filePath = & $PathStyleScript -Item $Item -PathParts $PathParts -Ext $Ext

        Write-Verbose "$funcName`: $filePath"
        $filePath | Select-Object
    }
}
