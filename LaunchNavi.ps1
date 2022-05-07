using namespace System.Drawing
$fileScriptPath = split-path -parent $MyInvocation.MyCommand.Definition

Import-Module "$fileScriptPath\Shell\FileSystem.ps1"
Import-Module "$fileScriptPath\Shell\UI.ps1"


initMainForm $fileScriptPath