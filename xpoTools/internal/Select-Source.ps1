#Requires -Version 5
Set-StrictMode -Version Latest

function Select-Source {
    [CmdletBinding()]
    [OutputType([xpoNode])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$SourceText
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose $funcName

        $SourceText |
            Select-String '(?<Open>SOURCE)\s#(?<Name>\w+)(?<Text>[\s\S]*?)(?<Close>ENDSOURCE)' -AllMatches |
            Select-Object -ExpandProperty Matches |
            ForEach-Object {

            $Name = $_.Groups['Name'].Value
            $Text = $_.Groups['Text'].Value.Trim()

            Write-Verbose "$funcName`: +$Name"
            [xpoNode]@{
                Name = $Name
                Text = $Text
            }
        }
    }
}