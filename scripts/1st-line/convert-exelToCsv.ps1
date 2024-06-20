# This script converts Excel files to CSV format
param (
    # Path to the Excel file
    [string]$excelFilePath,
    
    # Path to save the CSV file
    [string]$csvFilePath
)

# Import the Excel file
$excel = Import-Excel -Path $excelFilePath

# Export the data to CSV
$excel | Export-Csv -Path $csvFilePath -NoTypeInformation
