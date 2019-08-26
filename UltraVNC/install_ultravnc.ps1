#garantir que sera executado como admin

param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}

exit
}

########################################################################################################################################

if ((gwmi win32_operatingsystem | select osarchitecture))
{
    #para sistemas 64 bits

    #remover ultravnc 

    cd  'C:\Program Files\uvnc bvba\UltraVNC' -EA SilentlyContinue

    Get-Service -DisplayName "uvnc_service" | Stop-Service

    .\unins000.exe /SP- /VERYSILENT  -EA SilentlyContinue

     Start-Sleep -Seconds 10

    cd  'C:\Program Files\'

    remove-item 'C:\Program Files\uvnc bvba' -Recurse   -EA SilentlyContinue

    #instando ultravnc

    cd 'C:\Instaladores\ultravnc'

    .\UltraVNC_1_2_24_X64_Setup.exe /LOADINF='C:\Instaladores\ultravnc\Install_64.txt' /VERYSILENT 

    #remove atalhos do menu iniciar

     remove-item "C:\Documents and Settings\All Users\Start Menu\Programs\UltraVNC" -Recurse   -EA SilentlyContinue

     remove-item "C:\Documents and Settings\All Users\Menu Iniciar\Programas\UltraVNC" -Recurse   -EA SilentlyContinue

    #renomeando arquivo de configuraçao do ultravnc

         Start-Sleep -Seconds 10

    rename-item -path  'C:\Program Files\uvnc bvba\UltraVNC\ultravnc.ini'  -newname ultravnc.ini.old
    
    #movendo arquivo de config do ultravnc

        Start-Sleep -Seconds 3

    Copy-Item C:\Instaladores\ultravnc\ultravnc_64.ini  -destination 'C:\Program Files\uvnc bvba\UltraVNC\ultravnc.ini'

    # restart vnc para pegar cofig novas

    Get-Service -DisplayName "uvnc_service" | Stop-Service

    Start-Sleep -Seconds 5

    Get-Service -DisplayName "uvnc_service" | Start-Service

}
else
{
    #para sistemas 32 bits
    
    cd 'C:\Instaladores\ultravnc'

    #.\UltraVNC_1_2_24_X64_Setup.exe /LOADINF='C:\Instaladores\ultravnc\Install_64.txt' /VERYSILENT
}