#Requires -Version 5

using namespace Microsoft.PowerShell.Commands
Set-StrictMode -Version Latest

function Import-Xpo {
    [CmdletBinding(DefaultParameterSetName = 'FileName')]
    [OutputType([psObject])]
    Param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'FileName')]
        [string[]]$Path,

        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'FileInfo')]
        [System.IO.FileInfo[]]$xpoFiles,

        [scriptblock]$FilterScript = {$_},
        [FileSystemCmdletProviderEncoding]$Encoding = [FileSystemCmdletProviderEncoding]::Default
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $xpoFiles"

        if ( $PSCmdlet.ParameterSetName -eq 'fileName' ) {
            $xpoFiles = Get-ChildItem $Path
        }

        $xpoFiles | Test-NotEmpty | ForEach-Object {
            $xpoFile = $_

            $Texts = Get-Content $xpoFile.FullName -Delimiter '***Element: ' -Encoding $Encoding

            if ( $Texts -and $Texts.Length -gt 2 -and $Texts[-1] -match 'END\s+$' ) {
                $FileHeader = $Texts[0]

                $Items = $Texts |
                    Select-Object -Skip 1 |
                    Select-Object -SkipLast 1 |
                    Select-XpoElement -FileHeader $FileHeader -xpoFile $xpoFile |
                    Where-Object -FilterScript $FilterScript |
                    ForEach-Object {

                    Write-Progress -Activity $funcName -Status $_
                    Write-Verbose "$funcName`: $_"

                    $_
                }

                Write-Progress -Activity $funcName -Completed

                $Nodes = $Items | Where-Object { $_ -and $_.Type.Tag -EQ 'PRN' } | ForEach-Object {
                    Write-Verbose "$funcName collects nodes for the project $_"
                    $_.GroupNode = $_ | select-ProjectGroup | select-ProjectNode
                    $_.GroupNode
                }

                $Items | Where-Object { $_ -and $_.Type.Tag -NE 'PRN' } | ForEach-Object {
                    Write-Verbose "$funcName creates a link to nodes for the $_"
                    $Item = $_
                    $Item.Node = $Nodes | Where-Object { $_ -eq $Item }
                }

                $Items | Select-Object
            }
            else {
                Write-Warning "$funcname`: File have skipped because It is not match with a xpo format. File $xpoFile"
            }
        }
    }
}
