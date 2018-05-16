function Select-TextLine {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$TextWithSharp,
        [string[]]$Ident
    )

    process {
        $TextWithSharp.Trim() -split "`r`n" | ForEach-Object {
            $s = $_ -replace '\s*?#(.*)', '$+'

            if ( $s -notmatch '^\s*$') {
                if ( $Ident ) {
                    $Ident | Select-Object
                }

                $s
            }
            "`r`n"
        }
    }
}