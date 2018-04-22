#Requires -Version 5

using namespace Microsoft.PowerShell.Commands
Set-StrictMode -Version Latest

function Out-XpoText {
    [CmdletBinding()]
    [OutputType([string])]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$Path,
        [string[]]$Text,
        [switch]$Force,
        [switch]$NoClobber,
        [FileSystemCmdletProviderEncoding]$Encoding = [FileSystemCmdletProviderEncoding]::Default,
        [switch]$PassThru
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $Path"

        $Path | 
            Split-Path -Parent |
            Test-NotEmpty |
            Where-Object { -not (Test-Path -Path $_) } |
            ForEach-Object {

            Write-Verbose "$funcName`: create directory $_"
            new-item -Path $_ -ItemType Directory -Force:$Force | Out-Null
        }

        $Path |
            Test-NotEmpty |
            ForEach-Object {
                
            Write-Verbose "$funcName`: write file $_"
            $Text | Out-File -FilePath $_ -Encoding $Encoding -NoNewline -Force:$Force -NoClobber:$NoClobber

            if ( $PassThru ) {
                $_
            }
        }
    }
}
