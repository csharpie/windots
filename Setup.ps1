# Setup script for Windots
#Requires -RunAsAdministrator

if ("Desktop" -eq $PSVersionTable.PSVersion) {
    Write-Error "You must run this setup script using PowerShell Core. Please open a PowerShell Core terminal." -ErrorAction Stop
}

# Ask if machine is work machine and then store as local environment variable
do {
    $isWorkMachine = (Read-Host -Prompt "Is this your work machine? Type 'Y' for Yes or 'N' for No: ").ToUpper()

    if ("Y" -eq $isWorkMachine) {
        [System.Environment]::SetEnvironmentVariable("IsWorkMachine", $true)
    }
    elseif ("N" -eq $isWorkMachine) {
        [System.Environment]::SetEnvironmentVariable("IsWorkMachine", $false)
    }
} until ($null -ne $env:IsWorkMachine)

# Setup Modules for Windows PowerShell
$command = ".\InstallModules.ps1"
$process = Start-Process powershell.exe -ArgumentList "-File $command" -Verb RunAs -PassThru -Wait -WindowStyle Hidden
$process.WaitForExit()
$exitCode = $process.ExitCode

# Check for success or failure based on the exit code
if ($exitCode -eq 0) {
    Write-Host "NuGet Package Provider installed successfully."
}
else {
    Write-Host "NuGet Package Provider install failed with exit code: $exitCode"
}

# Setup Applications
.\SetupApplications.ps1

# Linked Files (Destination => Source)
## Borrowed from: https://github.com/scottmckendry/Windots/blob/main/Setup.ps1
$symlinks = @{
    "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" = ".\Profile.ps1"
    "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"        = ".\Profile.ps1"
    "$HOME\Documents\PowerShell\Microsoft.VSCode_profile.ps1"            = ".\Profile.ps1"
    "$HOME\Documents\WindowsPowerShell\Aliases.ps1"                      = ".\Aliases.ps1"
    "$HOME\Documents\PowerShell\Aliases.ps1"                             = ".\Aliases.ps1"
    # "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" = ".\windowsterminal\settings.json"
    "$HOME\.gitconfig"                                                   = ".config\git\.gitconfig"
}

# Create Symbolic Links
## Borrowed from: https://github.com/scottmckendry/Windots/blob/main/Setup.ps1
Write-Host "Creating Symbolic Links..."
foreach ($symlink in $symlinks.GetEnumerator()) {
    Get-Item -Path $symlink.Key -ErrorAction SilentlyContinue | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path $symlink.Key -Target (Resolve-Path $symlink.Value) -Force | Out-Null
}

.\InstallModules.ps1

# Install Fonts
# Function to install Nerd Fonts 
# Borrowed from: https://github.com/ChrisTitusTech/powershell-profile/blob/main/setup.ps1
function Install-NerdFonts {
    param (
        [string]$FontName = "CascadiaCode",
        [string]$FontDisplayName = "CaskaydiaCove NF",
        [string]$Version = "3.2.1"
    )

    Write-Host "Installing Cascadia Code..."
    try {
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        if ($fontFamilies -notcontains "${FontDisplayName}") {
            $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${Version}/${FontName}.zip"
            $zipFilePath = "$env:TEMP\${FontName}.zip"
            $extractPath = "$env:TEMP\${FontName}"

            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFileAsync((New-Object System.Uri($fontZipUrl)), $zipFilePath)

            while ($webClient.IsBusy) {
                Start-Sleep -Seconds 2
            }

            Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
            $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
            Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                    $destination.CopyHere($_.FullName, 0x10)
                }
            }

            Remove-Item -Path $extractPath -Recurse -Force
            Remove-Item -Path $zipFilePath -Force
        }
        else {
            Write-Host "Font ${FontDisplayName} already installed"
        }
    }
    catch {
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}

function Install-JetBrainsMonoFont {
    param (
        [string]$FontName = "JetBrainsMono",
        [string]$FontDisplayName = "JetBrains",
        [string]$Version = "2.304"
    )

    Write-Host "Installing JetBrains Mono..."
    try {
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        if ($fontFamilies -notcontains "${FontDisplayName}") {
            $fontZipUrl = "https://download.jetbrains.com/fonts/${FontName}-${Version}.zip"
            $zipFilePath = "$env:TEMP\${FontName}.zip"
            $extractPath = "$env:TEMP\${FontName}"

            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFileAsync((New-Object System.Uri($fontZipUrl)), $zipFilePath)

            while ($webClient.IsBusy) {
                Start-Sleep -Seconds 2
            }

            Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
            $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
            Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                    $destination.CopyHere($_.FullName, 0x10)
                }
            }

            Remove-Item -Path $extractPath -Recurse -Force
            Remove-Item -Path $zipFilePath -Force
        }
        else {
            Write-Host "Font ${FontDisplayName} already installed"
        }
    }
    catch {
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}

Install-NerdFonts
Install-JetBrainsMonoFont
