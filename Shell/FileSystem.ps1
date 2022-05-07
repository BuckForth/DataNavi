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

function Get-Tree{
    param (
        [string][parameter(mandatory=$true, Valuefrompipeline = $true)] $Path  #[string] Directory to begin file search
    )
    $node = New-Object System.Windows.Forms.TreeNode
    $node.text = split-path -leaf $Path 

    Get-ChildItem "$Path" | 
    Foreach-Object {
        if($_ -is [System.IO.DirectoryInfo])
            {$subnode = Get-Tree $_.FullName}
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

Function Out-GridList {
    [cmdletbinding()]
    
    Param(
        [Parameter(Position=0,Mandatory,ValueFromPipeline)]
        [object]$InputObject,
        [string]$Title="Out-GridList",
        [switch]$Passthru
    )
    
    Begin 
    {
        #initialize data array
        $data=@()
    }
    Process 
    {
        #initialize a hashtable for properties
        $propHash = @{}
        #get property names from the first object in the array
        $properties = $InputObject | Get-Member -MemberType Properties
        
        $properties.name | foreach {
        Write-Verbose "Adding $_"
        $propHash.add($_,$InputObject.$_)
        } #foreach
        
        $data +=$propHash
        
    } #Process 
    End 
    {
        #tweak hashtable output
        $data.GetEnumerator().GetEnumerator() | 
        Select-Object @{Name="Property";Expression={$_.name}},Value |
        Out-GridView -Title $Title -PassThru:$Passthru
    }
    
} #end Out-Gridlist