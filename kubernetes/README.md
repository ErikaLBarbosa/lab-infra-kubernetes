<!-- Título do Projeto -->
<h1 align="center">Módulo Kubernetes</h1>

<!-- Descrição do Projeto -->
# Descrição do Projeto
Este módulo é destinado a criação do Cluster Kubernetes.
Já com as instancias criadas e com os pré requisitos devidamente instalados, esse diretório possui tudo que é necessário para provisionar o cluster kubernetes.

<!-- Estrutura -->
## Estrutura de arquivos e diretórios

###### Diretório raiz (diretório atual)
Possui os arquivos terraform onde foram usados null_resources para conexão na máquina e execução de scripts inline. Foi utilizado o [kubeamd](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/) para a construção dos clusters. 

###### Diretório templates
Possui os arquivos templates para a configuração do init e do join.
Documentação do kubeadm citada acima mostra com maior clareza o porque da utilização destes arquivos e como configura-los. Lembrando que são *templates*, logo qualquer alteração deve ser realizada através das variáveis.

**OBS:** Para utilizar este repositório deve-se atentar a edição das informações como variáveis, credentials da aws e etc. 