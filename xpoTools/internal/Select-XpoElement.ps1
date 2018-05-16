function Select-XpoElement {
    [CmdletBinding()]
    [OutputType([xpoITem])]
    Param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [string]$Text,
        [System.IO.FileInfo]$xpoFile = (throw "The xpoFile parameters required."),
        [string]$FileHeader = (throw "The xpoFile parameters required.")
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $xpoFile"

        if ( $Text -match '^(?<Tag>\w+)[\s\S]+?\b(?<Type>\w+) #(?<Name>\w*)' ) {
            $Tag = $Matches['Tag']
            $xpoType = $Matches['Type']
            $Name = $Matches['Name']

            $SubTag = if ( ($Tag -eq 'PRN') -and ($Text -match "$xpoType #$Name\s+(?<SubTag>\w+)") ) {
                $Matches['SubTag']
            }
            elseif ( ($Tag -eq 'FTM') -and ($Text -match "$xpoType #$Name\s+Type: (?<SubTag>\d+)") ) {
                $Matches['SubTag']
            }
            else {
                ''
            }

            Get-XpoType $Tag $SubTag | ForEach-Object {
                $type = $_
                [xpoItem]@{
                    Name       = $Name
                    xpoType    = $xpoType
                    Type       = $type
                    Text       = $Text
                    SourceFile = $xpoFile
                    FileHeader = $FileHeader
                }
            }
        }
        elseif ( $Text -match '^DOK[\s\S]+?(?<type>#KERNDOC:[\w\\]+)' ) {
            $xpoType = $Matches['type']
            Write-Warning "$funcname`: Text with documentation (Element: DOK $xpoType...) have skipped in $xpoFile."
        }
        else {
            $TextForErr = $Text -split "`n", 4
            $TextForErr = $TextForErr | ForEach-Object { '> ' + $_ }
            if( $TextForErr.Length -eq 4 ) {
                $TextForErr[4] = '> ...'
            }
            $TextForErr = $TextForErr -join "`n"
            Write-Warning "$funcname`: Text have skipped because It is not match with a xpo format in $xpoFile.`r`n$TextForErr"
        }
    }
}
