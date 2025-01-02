# Windots

Setup files for getting my Windows machines configured.

## Getting started

Run the following command in the directory of the cloned repository:

```pwsh
.\Setup.ps1
```

## File Anatomy

- Setup.ps1
  - Runs setup
    - Requires an Elevated Prompt and must be run in a PowerShell Core terminal
- Profile.ps1
  - PowerShell profile that gets symbolically linked to the directories for Windows PowerShell, PowerShell Core and VS Code PowerShell
- InstallModules.ps1
  - Installs NuGet package manager for Windows PowerShell (needed to install other modules)
  - Installs list of hard-coded modules
- SetupApplications.ps1
  - Installs applications that I commonly use at home or at work
- .config/
  - git/
    - .gitconfig
      - Settings for git CLI
      - I use a _.gitconfig_local_ for name, email and user name preferences but I maintain this file locally.
  - starship.toml
    - Contains customizations such as a palette to use Monokai themed colors

## Inspirations

- Creating Symbolic Links

  - [Save your PowerShell Profile in dotfiles repo by Koen Verburg](https://conradtheprogrammer.medium.com/save-your-powershell-profile-in-your-dotfiles-repo-8ec723532934)
  - [Windots from Scott McKendry](https://github.com/scottmckendry/Windots/blob/main/Setup.ps1)

- Installing applications

  - [setupmachine.bat from Scott Hanselman's gist](https://gist.github.com/shanselman/6b91a78a2db92b81dd07cb28534ee875)

- Installing NerdFonts

  - [powershell-profile from ChrisTitusTech](https://github.com/ChrisTitusTech/powershell-profile/blob/main/setup.ps1)

- .gitconfig setup
  - [So You Think You Know Git by Scott Chacon](https://www.youtube.com/watch?v=aolI_Rz0ZqY)
