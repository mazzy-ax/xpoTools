#Requires -Version 5

using namespace Microsoft.PowerShell.Commands
Set-StrictMode -Version Latest

function Split-Xpo {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [xpoItem[]]$Items,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$DestinationPathParts,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$xpp,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$NoClobber,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$Force,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$Include,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string[]]$Exclude,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$OverwriteNewer,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [scriptblock]$FilterScript = {$_},

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [FileSystemCmdletProviderEncoding]$Encoding = [FileSystemCmdletProviderEncoding]::Default,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [ValidateSet('Default', 'mazzy', 'AOT', 'Flat', 'FlatAOT', 'FlatProject', 'Project', 'All')]
        [string]$PathStyle = 'Default',
        
        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [scriptblock]$PathStyleScript,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$PassThru
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose $funcName

        $Items |
            Test-NotEmpty |
            Where-Object -FilterScript $FilterScript |
            ForEach-Object {

            $Item = $_

            if ( $xpp -and $Item.Type.Tag -eq 'CLS' ) {
                $Ext = '.xpp'
                $s = $Item.Text | Select-Source | Select-xppClass
            }
            elseif( $xpp -and $Item.Type.Tag -eq 'JOB' ) {
                $Ext = '.xpp'
                $s = $Item.Text | Select-Source | Select-Object -First 1 -ExpandProperty Text | Select-TextLine
            }
            else {
                $Ext = '.xpo'
                $s = @() + $Item.FileHeader + $Item.Text + "END`r`n"
            }

            $Item |
                Select-FileName -PathParts $DestinationPathParts -Ext $Ext -PathStyle $PathStyle -PathStyleScript $PathStyleScript |
                Select-Included -Include $Include -Exclude $Exclude |
                Test-DestinationPath -Item $Item -NoClobber:$NoClobber -Force:$Force -OverwriteNewer:$OverwriteNewer |
                Out-XpoText -Text $s -NoClobber:$NoClobber -Force:$Force -Encoding $Encoding -PassThru:$PassThru
        }
    }
}
