#Script to check Exel module existence on device
#If doesn not exist on device, it will then get installed
 $module_name = 'importExcel'
if(-not (Get-Module $module_name -ListAvailable)){
Install-Module $module_name -Scope CurrentUser -Force
}
