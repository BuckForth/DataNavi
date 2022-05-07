using namespace System.Drawing
Add-Type -AssemblyName System.Drawing
Import-Module "$(split-path -parent $MyInvocation.MyCommand.Definition)\FileSystem.ps1"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.drawing")
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")

function initMainForm {
    param
    (
        [string][parameter(mandatory=$true, Valuefrompipeline = $true)] $Path
    )
    # Innitialize Main Form
    [System.Windows.Forms.Application]::EnableVisualStyles();
    $mainForm = new-object Windows.Forms.Form
    $mainForm.Text = "Navi-Gator Tool"
    $mainForm.Width = 640;
    $mainForm.Height = 480;

    #create Navigator Panel
    $naviPanel = New-Object System.Windows.Forms.TableLayoutPanel
    $naviPanel.ColumnCount = 3
    $naviPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
    $coll5 = New-Object System.Windows.Forms.ColumnStyle @([System.Windows.Forms.SizeType]::Percent, 1)
    $coll35 = New-Object System.Windows.Forms.ColumnStyle @([System.Windows.Forms.SizeType]::Percent, 39)
    $coll60 = New-Object System.Windows.Forms.ColumnStyle @([System.Windows.Forms.SizeType]::Percent, 60)

    $naviPanel.ColumnStyles.Add($coll35);
    $naviPanel.ColumnStyles.Add($coll5);
    $naviPanel.ColumnStyles.Add($coll60);

    $naviPanel.RowCount = 1
    $naviPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D

        # create Treeview-Object
        $DirTreeView = New-Object System.Windows.Forms.TreeView
        $DirTreeView.Dock = [System.Windows.Forms.DockStyle]::Fill
        $naviPanel.Controls.Add($DirTreeView, 0, 0)
        # create Root-Node
        $rootnode = Get-Tree $Path
        $rootnode.text = "root"
        $rootnode.name = "root"
        [void]$DirTreeView.Nodes.Add($rootnode)

        $naviDIVPanel = New-Object System.Windows.Forms.Panel
        $naviDIVPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
        $naviDIVPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
        $naviPanel.Controls.Add($naviDIVPanel, 1, 0)

        #Create Property Grid
        $PropertyGrid = New-Object "System.Windows.Forms.PropertyGrid"
        $PropertyGrid.Dock = [System.Windows.Forms.DockStyle]::Fill
        $naviPanel.Controls.Add($PropertyGrid, 2, 0)
        
    ##Add Navigator Panel to form
    $mainForm.Controls.Add($naviPanel)

    # create Drawing window
    $pictureBox = new-object Windows.Forms.PictureBox
    $pictureBox.Width =  128;
    $pictureBox.Height =  128;
    $pictureBox.Image = $img;

    $mainForm.controls.add($pictureBox)
    $mainForm.Add_Shown( { $mainForm.Activate() } )
    $mainForm.ShowDialog()      
}
