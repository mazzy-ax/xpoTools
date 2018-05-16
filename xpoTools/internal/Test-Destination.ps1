function Test-DestinationPath {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$Path,
        [xpoItem]$Item,
        [string[]]$Text = ( $Item | Select-Object -ExpandProperty Text ),
        [System.IO.FileInfo]$SourceFile = ( $Item | Select-Object -ExpandProperty SourceFile ),
        [switch]$NoClobber,
        [switch]$Force,
        [switch]$OverwriteNewer
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $Path"

        $fileExists = Test-Path $Path
        if ( $fileExists ) {
            if( $NoClobber ) {
                Write-Warning "The file $Path exists and -NoClobber parameter used. The file is not changed."
                return
            }

            if ( $SourceFile ) {
                $file = Get-ChildItem $Path | Select-Object -First 1
                if ( $file.FullName -eq $SourceFile.FullName ) {
                    Write-Warning "Names of the source and the destination files are same. The file $Path is not changed."
                    return
                }
                elseif ( -not $OverwriteNewer -and (Get-ChildItem $Path).LastWriteTime -ge $SourceFile.LastWriteTime ) {
                    Write-Verbose "The file $Path have created later than source xpo-project. The file is not changed. Use -OverwriteNewer parameter to overwrite it."
                    return
                }
                # TODO mazzy: too slow. To get more effective code
                #elseif ( $fileExistsExists -and (($Text | Out-String) -eq (Get-Content $Path -Raw -Encoding UTF8)) ) {
                #    Write-Warning "A content of the text and the destination file are same. The file $Path is not changed."
                #}
            }
        }

        Write-Verbose "$funcName`: Ok"
        $Path
    }
}
