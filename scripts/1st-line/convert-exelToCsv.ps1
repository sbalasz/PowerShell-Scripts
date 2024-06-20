#Script to convert excel to csv
 $hrFilePath = "\\share\filepath"

if (!(Test-Path -Path "$hrFilePath\$today.csv")){
    Write-host("Converting excel file to csv... ") -BackgroundColor Blue
    $hrExport = Import-Excel -Path "$hrFilePath\$today.xlsx" -StartRow 7
    $convertedHRreport = $hrExport | Export-Csv -Encoding UTF8 "$hrFilePath\$today.csv" -NoTypeInformation
    Write-host("Excel converted to csv and saved to $hrFilePath") -BackgroundColor Blue
}else{Write-host("CSV for today already in place") -BackgroundColor Green}
