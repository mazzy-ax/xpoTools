#Requires -Version 5
Set-StrictMode -Version Latest

[string]$script:Ident = "".PadRight(4) # 4 spaces

function Select-xppClass {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [xpoNode[]]$Texts
    )

    begin {
        $classDeclarations = @()
        $methods = @()
    }

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose $funcName

        $classDeclarations += $Texts |
            Where-Object Name -eq 'classDeclaration' |
            Select-Object -First 1 -ExpandProperty Text |
            ForEach-Object {

            # try to remove last lines with '}' and spaces
            if ( $_ -match '([\s\S]*{[\s\S]*)}' ) {
                $Matches[1] | select-TextLine | Select-Object -SkipLast 2
            }
            else {
                $_
            }

            "`r`n"
        }

        $methods += $Texts |
            Where-Object Name -ne 'classDeclaration' |
            Select-Object -ExpandProperty Text |
            ForEach-Object {

            "`r`n"

            # insert $Ident to the each not empty line
            $_ | Select-TextLine -Ident $script:Ident
        }
    }

    end {
        if( $classDeclarations ) {
            @() + $classDeclarations + $methods + '}'
        }
        else {
            @() + $methods
        }
    }
}
