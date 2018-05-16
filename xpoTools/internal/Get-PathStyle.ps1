
$script:xpoDestinationPathStyle = @{

    mazzy = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $filePath = $Item.Node | ForEach-Object {
            $GroupPath = if ( $_ ) { $_.Path } else { '' }

            $p = @() + $PathParts + $GroupPath + $fileName | Test-NotEmpty
            $p -join '\'
        } | Select-Object -Unique

        Write-Verbose "$funcName`: $filePath"
        $filePath | Select-Object
    }

    Flat = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $p = @() + $PathParts + $fileName | Test-NotEmpty
        $filepath = $p -join '\'

        Write-Verbose "$funcName`: $filePath"
        $filePath

    }

    Default = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $AOTpath = if ( $Item -and $Item.Type ) { $Item.Type.AOTpath } else { '' }
        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $p = @() + $PathParts + $AOTpath + $fileName | Test-NotEmpty
        $filepath = $p -join '\'

        Write-Verbose "$funcName`: $filePath"
        $filePath
    }

    AOT = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $AOTpath = if ( $Item -and $Item.Type ) { $Item.Type.AOTpath } else { '' }
        $fileName = @() + $Item.Name + $ext -join ''

        $p = @() + $PathParts + $AOTpath + $fileName | Test-NotEmpty
        $filepath = $p -join '\'

        Write-Verbose "$funcName`: $filePath"
        $filePath
    }

    FlatAOT = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $AOTpath = if ( $Item -and $Item.Type ) { $Item.Type.OneLevelAOTPath } else { '' }
        $fileName = @() + $Item.Name + $ext -join ''

        $p = @() + $PathParts + $AOTpath + $fileName | Test-NotEmpty
        $filePath = $p -join '\'

        Write-Verbose "$funcName`: $filePath"
        $filePath
    }

    Project = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $filePath = $Item.Node | ForEach-Object {
            $ProjectName = if ( $_ -and $_.Project ) { $_.Project.Name.Trim() } else { '' }
            $GroupPath = if ( $_ ) { $_.Path } else { '' }

            $p = @() + $PathParts + $ProjectName + $GroupPath + $fileName | Test-NotEmpty
            $p -join '\'
        } | Select-Object -Unique

        Write-Verbose "$funcName`: $filePath"
        $filePath | Select-Object
    }

    FlatProject = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $filePath = $Item.Node | ForEach-Object {
            $ProjectName = if ( $_ -and $_.Project ) { $_.Project.Name.Trim() } else { '' }

            $p = @() + $PathParts + $ProjectName + $fileName | Test-NotEmpty
            $p -join '\'
        } | Select-Object -Unique

        Write-Verbose "$funcName`: $filePath"
        $filePath | Select-Object
    }

    All = {
        param([xpoItem]$Item, [String[]]$PathParts, [String]$Ext)

        $AOTpath = if ( $_ -and $Item.Type ) { $_.Type.AOTpath } else { '' }
        $fileName = @() + $Item.Type.FilePrefix + '_' + $Item.Name + $ext -join ''

        $filePath = $Item.Node | ForEach-Object {
            $ProjectName = if ( $_ -and $_.Project ) { $_.Project.Name.Trim() } else { '' }
            $GroupPath = if ( $_ ) { $_.Path } else { '' }

            $p = @() + $PathParts + $ProjectName + $GroupPath + $AOTpath + $fileName | Test-NotEmpty
            $p -join '\'
        } | Select-Object -Unique

        Write-Verbose "$funcName`: $filePath"
        $filePath | Select-Object
    }
}

function Get-PathStyle {
    [CmdletBinding()]
    [OutputType([scriptblock])]
    param (
        [Parameter(Position = 0, ValueFromPipeline)]
        [ValidateSet('Default', 'mazzy', 'AOT', 'Flat', 'FlatAOT', 'FlatProject', 'Project', 'All')]
        [string]$Style = 'Default'
    )

    process {
        $script:xpoDestinationPathStyle[$Style]
    }
}
