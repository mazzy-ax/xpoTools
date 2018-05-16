function Select-ProjectNode {
    [CmdletBinding()]
    [OutputType([xpoNode])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [xpoNode]$xpoNode
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $xpoNode"

        $xpoNode |
            Test-NotEmpty |
            Select-Object -ExpandProperty Text |
            Select-String -Pattern '(?<Open>BEGINNODE)(?<Text>[\s\S]*?\bNAME\s#(?<Name>\w+)\b[\s\S]*?)(?<Close>ENDNODE)' -AllMatches -CaseSensitive |
            Select-Object -ExpandProperty Matches |
            ForEach-Object {

            $Name = $_.Groups['Name'].Value
            $Text = $_.Groups['Text'].Value.Trim()

            $UtilType = if ( $Text -match '\bUTILTYPE\s(?<utilType>\d+)\b' ) { $Matches['utilType'] } else { '' }
            $NodeType = if ( $Text -match '\bNODETYPE\s(?<nodeType>\d+)\b' ) { $Matches['nodeType'] } else { '' }

            Write-Verbose "$funcName`: +$Name"
            [xpoNode]@{
                Name     = $Name
                Text     = $Text
                Path     = $xpoNode.Path
                NodeType = $NodeType
                UtilType = $UtilType
                Parent   = $xpoNode
                Project  = $xpoNode.Project
            }
        }
    }
}
