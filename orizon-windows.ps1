# Nome do arquivo ZIP
$arquivoZip = "Zabbix.zip"

# Caminho para o diretório onde o script está localizado
$scriptDiretorio = Split-Path -Parent $MyInvocation.MyCommand.Path

# Caminho completo para o arquivo ZIP
$caminhoArquivoZip = Join-Path -Path $scriptDiretorio -ChildPath $arquivoZip

# 1 - Descompactar o arquivo Zabbix.zip na raiz do disco C
Expand-Archive -Path $caminhoArquivoZip -DestinationPath "C:\" -Force

# Caminho para o diretório onde os arquivos foram extraídos
$caminhoExtracao = Join-Path -Path "C:\" -ChildPath ($arquivoZip -Replace '\.zip$','')

# Caminho completo para o executável do Zabbix Agent 2
$caminhoExecutavel = Join-Path -Path $caminhoExtracao -ChildPath "zabbix_agent2.exe"

# 2 - Executar os comandos no PowerShell como administrador
# Primeiro comando: .\zabbix_agent2.exe -c .\zabbix_agent2.conf -i
Start-Process -FilePath $caminhoExecutavel -ArgumentList "-c", "$caminhoExtracao\zabbix_agent2.conf", "-i" -Wait -NoNewWindow -PassThru

# Segundo comando: Start-Service "Zabbix Agent 2"
Start-Service -DisplayName "Zabbix Agent 2"
