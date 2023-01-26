<!-- Título do Projeto -->
<h1 align="center">Módulo AWS</h1>

<!-- Descrição do Projeto -->
# Descrição do Projeto
Este módulo é destinado a criação das instancias na aws.
Será criada duas instancias ec2 (so amazon linux), uma será ocontrol plane e a outra será um worker. Além de ser criado um eip para cada instancia.

<!-- Estrutura -->
## Estrutura de arquivos e diretórios

###### Diretório raiz (diretório atual)
Diretório onde encontramos os arquivos terraform.

###### Diretório arquivos_config
Neste diretório temos alguns arquivos que serão inseridos nas instancias criadas para a configuração de containerd, docker, sysctl entre outros. Essas configurações são indicadas como necessárias na documentação do kubernetes.

###### Diretório networking
Onde está o módulo networking.

###### Diretório scripts
Possui um arquivo sh que irá realizar todos os updates e instalações necessárias para o funcionamento das nossas instancias. Esse script prepara todos os pré requisitos para que a gente consiga utilizar o kubernetes nas instancias ec2.

**OBS:** Para utilizar este repositório deve-se atentar a edição das informações como variáveis, credentials da aws e etc. 

