#Requires -Version 5
Set-StrictMode -Version Latest

function Select-ProjectGroup {
    [CmdletBinding()]
    [OutputType([xpoNode])]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [xpoItem]$Project
    )

    process {
        $funcName = $MyInvocation.InvocationName
        Write-Verbose "$funcName`: $Project"

        # root
        $Current = [xpoNode]@{
            Project = $Project
            Name    = $_.Name
            Path    = @()
        }

        # groups with a root
        $Project.Group = @( $Current )

        # get nodes
        $Project.Text -split '(GROUP\s#\w+|ENDGROUP)' | ForEach-Object {
            if ( $_ -match 'GROUP #(?<Name>\w+)' ) {
                $Name = $Matches['Name']
                $Parent = $Current

                $Current = [xpoNode]@{
                    Name    = $Name
                    Parent  = $Parent
                    Path    = $Parent.Path + $Name
                    Project = $Project
                }

                $Project.Group += $Current

                Write-Verbose "$funcName`: GROUP: +group $Current"
            }
            elseif ( $_ -match 'ENDGROUP' ) {
                $Parent = $Current.Parent
                Write-Verbose "$funcName`: ENDGROUP for group $Current. The Current points to the parent $Parent"

                $Current = $Parent
            }
            else {
                $Current.Text += $_
                Write-Verbose "$funcName`: Source text have added to the group $Current"
            }
        }

        Write-Verbose "$funcName`: $($Project.Group.Length) project groups pushes to the pipe."
        $Project.Group | Select-Object
    }
}
