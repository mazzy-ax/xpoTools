class xpoType {  
    [int]$NodeType
    [int]$UtilType
    [string]$Tag
    [string]$SubTag

    [string]$FilePrefix
    [string[]]$AOTpath
    [string]$OneLevelAOTPath

    [string]ToString() {
        return '{0}, {1}' -f $this.Tag, $this.FilePrefix
    }

    [boolean]Equals($InputObject) {
        $ret = $false

        if ( $InputObject -is [xpoItem] ) {
            $ret = $InputObject.Type -and (($this.NodeType -EQ $InputObject.Type.NodeType) -or
                (($this.Tag -EQ $InputObject.Type.Tag) -and ($this.SubTag -EQ $InputObject.Type.SubTag)))
        }
        elseif ( $InputObject -is [xpoNode] ) {
            $ret = ($this.NodeType -EQ $InputObject.NodeType) -and ($this.UtilType -EQ $InputObject.UtilType);
        }
        else {
            $ret = $this.Equals($InputObject)
        }

        return $ret
    }

}

class xpoItem {
    [string]$Name
    [string]$xpoType
    [xpoType]$Type
    [string[]]$Text
    [System.IO.FileInfo]$SourceFile
    [string]$FileHeader

    [string]ToString() {
        return '{0},{1}' -f $this.Type.FilePrefix, $this.Name
    }

    [xpoNode[]]$Node
    [xpoNode[]]$Group
    [xpoNode[]]$GroupNode

    [boolean]Equals($InputObject) {
        $ret = $false

        if ( $InputObject -is [xpoItem] ) {
            $ret = $this.name -eq $InputObject.Name -and $this.Type.Equals($InputObject.Type)
        }
        else {
            $ret = $this.Equals($InputObject)
        }

        return $ret
    }

}

class xpoNode {
    [string]$Name

    [string[]]$Text
    [string[]]$Path

    [int]$NodeType
    [int]$UtilType

    [xpoNode]$Parent
    [xpoItem]$Project

    [string]ToString() {
        return $this.Name
    }

    [boolean]Equals($InputObject) {
        $ret = $false

        if ( $InputObject -is [xpoItem] ) {
            $ret = $InputObject.Type -and
            ($this.NodeType -EQ $InputObject.Type.NodeType) -and
            ($this.UtilType -EQ $InputObject.Type.UtilType) -and
            ($this.Name -EQ $InputObject.Name)
        }
        elseif ( $InputObject -is [xpoNode] ) {
            $ret = ($this.NodeType -EQ $InputObject.NodeType) -and
            ($this.UtilType -EQ $InputObject.UtilType) -and
            ($this.Name -EQ $InputObject.Name) -and
            ($this.Parent -EQ $InputObject.Parent) -and
            ($this.Project -EQ $InputObject.Project);
        }
        else {
            $ret = $this.Equals($InputObject)
        }

        return $ret
    }
}