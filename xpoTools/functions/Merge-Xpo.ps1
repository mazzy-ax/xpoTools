function Merge-Xpo {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [xpoItem[]]$xpoItem,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [string]$DestinationPath,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$NoClobber,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$Force,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [scriptblock]$FilterScript = {$_},

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        $Encoding = 'UTF8',

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [switch]$PassThru
    )

    begin {
        $Items = @()
    }

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose $funcName

        $Items += $xpoItem | Test-NotEmpty | Where-Object -FilterScript $FilterScript
    }

    end {
        if ( $Items ) {
            $s = @()
            $s += $Items[0].FileHeader
            $s += $Items | Select-Object -ExpandProperty Text
            $s += "END`r`n"

            $DestinationPath |
                Test-DestinationPath -NoClobber:$NoClobber -Force:$Force |
                Out-XpoText -Text $s -NoClobber:$NoClobber -Force:$Force -Encoding $Encoding -PassThru:$PassThru
        }
    }
}
