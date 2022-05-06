function GetFilesFromFolder {
    param (
        [string][parameter(mandatory=$true, Valuefrompipeline = $true)] $Path,  #[string] Directory to begin file search
        [string][parameter(Valuefrompipeline = $true)] $ext = "*",              #[string] File extention type to look for.
        [switch][parameter(Valuefrompipeline = $true)] $Recurse                     #[flag.switch] include sub-directories in search?
    )
    if ($Recurse){$filesRet = Get-ChildItem -Recurse "$Path\*.$ext"}
    else{$filesRet = Get-ChildItem  "$Path\*.$ext"}
    $filesRet  | 
    Foreach-Object {
        $inputFileName = $_.FullName
        $inputFileName
    }
}

function GetDirectoryListing{
    param (
        [string][parameter(mandatory=$true, Valuefrompipeline = $true)] $Path,  #[string] Directory to begin file search
        [switch][parameter(Valuefrompipeline = $true)] $Recurse                 #[flag.switch] include sub-directories in search?
    )
    if ($Recurse){$filesRet = Get-ChildItem -Recurse "$Path"}
    else{$filesRet = Get-ChildItem  "$Path"}
    $filesRet  | 
    Foreach-Object {
        $inputFileName = $_.FullName
        $inputFileName
    }
}

function GetTree{
    param (
        [string][parameter(mandatory=$true, Valuefrompipeline = $true)] $Path  #[string] Directory to begin file search
    )
    $node = New-Object System.Windows.Forms.TreeNode
    $node.text = split-path -leaf $Path 

    Get-ChildItem "$Path" | 
    Foreach-Object {
        if($_ -is [System.IO.DirectoryInfo])
            {$subnode = GetTree $_.FullName}
        else
        {
            $subnode = New-Object System.Windows.Forms.TreeNode
            $subnode.name = $_.FullName
		    $subnode.text = $_.Name
        }
        [void]$node.Nodes.Add($subnode)
    }
    $node
}