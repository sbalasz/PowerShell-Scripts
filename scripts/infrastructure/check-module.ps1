$module_name = 'importExcel'
if(-not (Get-Module $module_name -ListAvailable)){
Install-Module $module_name -Scope CurrentUser -Force
}