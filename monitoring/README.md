<!-- Título do Projeto -->
<h1 align="center">Módulo Monitoring</h1>

<!-- Descrição do Projeto -->
# Descrição do Projeto
Este módulo é destinado a instalação do Prometheus e do Grafana, instalação realizada através do helm.

<!-- Estrutura -->
## Estrutura de arquivos e diretórios

###### Diretório raiz (diretório atual)
Possui arquivos terraform, onde foi utilizado o null_resource para a conexão com a instancia e a execução dos scripts.

###### Diretório scripts
Possui o arquivo sh com os comandos necessários para a instalação do Prometheus e Grafana com helm.