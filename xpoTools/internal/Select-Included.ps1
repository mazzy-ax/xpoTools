#Requires -Version 5
Set-StrictMode -Version Latest

function Select-Included {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$Path,
        [string[]]$Include,
        [string[]]$Exclude
    )

    process {
        $funcName = $MyInvocation.InvocationName

        $PathPart = $Path.Trim() -split '\s*[\\/]\s*'

        if ( $Include -and -not ($Include | Where-Object { $PathPart -like $_ -or $Path -like $_ } | Select-Object -First 1) ) {
            Write-Verbose "$funcName`: $path not included in [$include]"
        }
        elseif ( $Exclude -and ($Exclude | Where-Object { $PathPart -like $_ -or $Path -like $_ } | Select-Object -First 1) ) {
            Write-Verbose "$funcName`: $path excluded from [$exclude]"
        }
        else {
            Write-Verbose "$funcName`: $path is ok"
            $Path
        }
    }
}
