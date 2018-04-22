[cmdletbinding()]
param()
Write-Verbose $PSScriptRoot

$functionFolders = @('classes', 'internal', 'functions')
ForEach ($folder in $functionFolders)
{
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath)
    {
        Write-Verbose -Message "Importing from $folder"
        $scripts = Get-ChildItem -Path $folderPath -Filter *.ps1


        $scripts | where-Object { $_.name -NotLike '*.Tests.ps1'} | ForEach-Object {
            Write-Verbose -Message "  Importing $_.basename"
            . $_.FullName
        }
    }
}

$publicFunctions = (Get-ChildItem -Path "$PSScriptRoot\functions\*.ps1").baseName
Export-ModuleMember -Function $publicFunctions