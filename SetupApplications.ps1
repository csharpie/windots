winget.exe install --id=Git.Git -e --accept-package-agreements --accept-source-agreements
winget.exe install --id=Microsoft.VisualStudioCode -e
winget.exe install --id=AgileBits.1Password -e
winget.exe install --id=Brave.Brave -e
winget.exe install --id=7zip.7zip -e
winget.exe install --id=Docker.DockerDesktop -e
winget.exe install --id=dotPDN.PaintDotNet -e
winget.exe install --id=File-New-Project.EarTrumpet -e
winget.exe install --id=GitHub.cli -e
winget.exe install --id=Google.Chrome -e
winget.exe install --id=LINQPad.LINQPad -e
winget.exe install --id=WestWind.MarkdownMonster -e
winget.exe install --id=Notepad++.Notepad++ -e
winget.exe install --id=Microsoft.dotnet -e
winget.exe install --id=OpenJS.NodeJS.LTS -e
winget.exe install --id=Microsoft.PowerShell -e
winget.exe install --id=Microsoft.PowerToys -e
winget.exe install --id=Postman.Postman -e
winget.exe install --id=Python.Python.3 -e
winget.exe install --id=Slack.Slack -e
winget.exe install --id=Starship.Starship -e
winget.exe install --id=Telerik.Fiddler.Classic -e
winget.exe install --id=VideoLAN.VLC -e

if ("Y" -eq $env:IsWorkMachine) {
    winget.exe install --id=SmartBear.SoapUI -e
    winget.exe install --id=mRemoteNG.mRemoteNG -e

    # Remote Server Administration Tools for Active Directory 
    Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LSD.Tools~~~~0.0.1.0
}
else {
    winget.exe install --id=Discord.Discord -e
    winget.exe install --id=OBSProject.OBSStudio -e
}