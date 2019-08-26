# - ################### DRIVER LEXMARK UNIVERSAL ###################

$porta = "porta_cgp";
$ip_impressora = "172.19.51.10";
$nome_impressora = "CGP";
$modelo_driver = "Lexmark Universal v2 XL";           # esse modelo de impressora esta no arquivo .inf;
                                                      # deve ser exatamente igual ao que esta no arquivo .inf
$arquitetura = "Windows x64";
$local_drive = "C:\Instaladores\scriptsImpressoras\Lexmark-MX710-Universal-V2\LMUD1p40.inf"


# http://woshub.com/manage-printers-and-drivers-from-the-command-line-in-windows-8/

# Cria Porta
cscript "C:\Windows\System32\Printing_Admin_Scripts\pt-BR\prnport.vbs" -a -h $ip_impressora -o RAW -n 9100 -r $porta

# Instala Driver [Descrição do parâmentro -m (model) tem que ser o mesmo que consta no arquivo .inf]
cscript "C:\Windows\System32\Printing_Admin_Scripts\pt-BR\prndrvr.vbs" -a -m "Lexmark Universal v2 XL" -v 3 -e $arquitetura -i $local_drive   

# Adiciona a Impressora
cscript "C:\Windows\System32\Printing_Admin_Scripts\pt-BR\prnmngr.vbs" -a -p $nome_impressora -m "Lexmark Universal v2 XL" -r $porta
