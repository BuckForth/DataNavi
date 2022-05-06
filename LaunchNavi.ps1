using namespace System.Drawing
$fileScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Add-Type -AssemblyName System.Drawing
Import-Module "$fileScriptPath\Shell\FileSystem.ps1"

[void][System.Reflection.Assembly]::LoadWithPartialName("System.drawing")
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")



# Innitialize Main Form
[System.Windows.Forms.Application]::EnableVisualStyles();
$mainForm = new-object Windows.Forms.Form
$mainForm.Text = "Navi-Gator Tool"
$mainForm.Width = 640;
$mainForm.Height = 480;
# create Treeview-Object
$DirTreeView = New-Object System.Windows.Forms.TreeView
$DirTreeView.Location = New-Object System.Drawing.Point(12, 12)
$DirTreeView.Size = New-Object System.Drawing.Size(290, 322)
$mainForm.Controls.Add($DirTreeView)
# create Root-Node
$rootnode = GetTree "$fileScriptPath"
$rootnode.text = "root"
$rootnode.name = "root"
[void]$DirTreeView.Nodes.Add($rootnode)

$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width =  128;
$pictureBox.Height =  128;
$pictureBox.Image = $img;

$mainForm.controls.add($pictureBox)
$mainForm.Add_Shown( { $mainForm.Activate() } )
$mainForm.ShowDialog()

