# set PowerShell to UTF-8
[System.Console]::InputEncoding = [System.Console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Aliases
. "$(Split-Path $PROFILE -Parent)\Aliases.ps1"

if ("Y" -eq $env:IsWorkMachine) {
    Import-Module -Name ActiveDirectory
}

# Modules
$modules = @("posh-git"; "PSReadLine", "Terminal-Icons", "z")
$modules | ForEach-Object {
    $module = $_
    if (Get-Module | Where-Object { $_.Name -eq $module }) {
        Write-Host "Module $module is already imported."
    }
    else {
        Import-Module -Name $module   
    }
}

# initialize starship shell
Invoke-Expression (&starship init powershell)