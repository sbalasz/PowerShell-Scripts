param (
    [string]$scriptsPath = "."
)

function Validate-Syntax {
    param (
        [string]$script
    )
    try {
        $null = Get-Command -Name $script -Syntax
        Write-Host "Syntax check passed for $script" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "Syntax check failed for $script`: $_" -ForegroundColor Red
        return $false
    }
}

function Check-RestrictedCmdlets {
    param (
        [string]$script
    )
    $restrictedCmdlets = @('Invoke-Expression', 'Invoke-Command', 'Start-Process')
    $content = Get-Content -Path $script
    foreach ($cmdlet in $restrictedCmdlets) {
        if ($content -match $cmdlet) {
            Write-Host "Restricted cmdlet '$cmdlet' found in $script" -ForegroundColor Red
            return $false
        }
    }
    Write-Host "No restricted cmdlets found in $script" -ForegroundColor Green
    return $true
}

function Check-Comments {
    param (
        [string]$script
    )
    $content = Get-Content -Path $script
    if ($content -notmatch '#') {
        Write-Host "No comments found in $script. Please add comments." -ForegroundColor Yellow
        return $false
    }
    Write-Host "Comments check passed for $script" -ForegroundColor Green
    return $true
}

function Run-Validation {
    param (
        [string]$script
    )
    $syntaxValid = Validate-Syntax -script $script
    $restrictedCmdletsValid = Check-RestrictedCmdlets -script $script
    $commentsValid = Check-Comments -script $script

    return ($syntaxValid -and $restrictedCmdletsValid -and $commentsValid)
}

# Get all .ps1 files in the specified directory
$scripts = Get-ChildItem -Path $scriptsPath -Filter *.ps1 -Recurse

$validationPassed = $true

foreach ($script in $scripts) {
    if (-not (Run-Validation -script $script.FullName)) {
        $validationPassed = $false
    }
}

if ($validationPassed) {
    Write-Host "All scripts passed validation." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some scripts failed validation." -ForegroundColor Red
    exit 1
}
