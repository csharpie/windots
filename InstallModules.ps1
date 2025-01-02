try {
    if ("Desktop" -eq $PSVersionTable.PSVersion) {
        # Install NuGet package provider
        Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    }
    # Modules
    $modules = @("posh-git"; "PSReadLine", "Terminal-Icons", "z")
    $modules | ForEach-Object {
        Write-Host "Installing the Module called $_ ..."
        Install-Module -Name $_ -Force -Scope AllUsers -AllowClobber
    }
}
catch {
    Write-Host $Error[0].Exception.GetType().FullName
    Write-Error -Message "InstallModules.ps1 errored: $_"
}

