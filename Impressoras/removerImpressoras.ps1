  
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

'running with full privileges'



 #impressoras que nao devem ser removidas
 [string[]] $impressoras = 'Microsoft XPS Document Writer','Microsoft Print to PDF','Fax';

 #impressoras que atualmente estao no computador
 [string[]] $impComputador = Get-Printer | Select-Object -Property Name;

foreach ($temp in $impComputador) {
    # retira os caracteres inuteis do nome da impressora
    $temp=$temp.Trim("@{Name=;}");
    if( $temp -in $impressorras){ 
        $temp + " será removida";  
    }else{ 
    $temp + " não será removida" ;  
    }
  
}