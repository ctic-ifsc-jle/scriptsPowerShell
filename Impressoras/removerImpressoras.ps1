# capturar nome das impressoras     https://paulosantanna.com/2016/12/19/exportar-informacoes-das-impressoras-no-windows-utilizando-powershell/
# foreach   https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-6

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