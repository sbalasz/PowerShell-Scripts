﻿$hrFilePath = "\\sbshares\CFCshares\IT\BalazsShare"

if (!(Test-Path -Path "$hrFilePath\$today.csv")){
    Write-host("Converting excel file to csv... ") -BackgroundColor Blue
    $hrExport = Import-Excel -Path "$hrFilePath\$today.xlsx" -StartRow 7
    $convertedHRreport = $hrExport | Export-Csv -Encoding UTF8 "$hrFilePath\$today.csv" -NoTypeInformation
    Write-host("Excel converted to csv and saved to $hrFilePath") -BackgroundColor Blue
}else{Write-host("CSV for today already in place") -BackgroundColor Green}