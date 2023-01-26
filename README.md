<!-- Título do Projeto -->
<h1 align="center">Laboratório de Kubernetes | Terraform | Prometheus | Grafana</h1>

<!-- Descrição do Projeto -->
# Descrição do Projeto
<p align="left">Este projeto é designado ao estudo de Kubernetes. Utilizando o Terraform para provisionar uma infraestrutura setando todos pré requisitos existentes na documentação do Kubernetes. Além da utilização de Prometheus (provisionado via helm) para coleta de métricas e o Grafana para criação de DashBoard. </p>

<!-- Status do Projeto -->
<h4 align="center"> 
	🚧  Em construção...  🚧
</h4>

<!-- Estrutura -->
## Estrutura de arquivos e diretórios

###### Diretório raiz (diretório atual)
<p align="left">Neste diretório é onde encontra-se nosso arquivo main do Terraform e é nesse diretório onde iremos utilizar o comando 'terraform apply' que irá provisionar todo nosso projeto. O projeto está estruturado através de módulos.</p>

<p align="left">Temos como módulos: </p>

* [AWS](https://github.com/ErikaLBarbosa/infra_kubernetes/tree/main/aws);
    - [Networking](https://github.com/ErikaLBarbosa/infra_kubernetes/tree/main/aws/networking);
* [Kubernetes](https://github.com/ErikaLBarbosa/infra_kubernetes/tree/main/kubernetes);
* [Monitoring](https://github.com/ErikaLBarbosa/infra_kubernetes/tree/main/monitoring);

<p align="left">Obs: Dentro de cada módulo haverá um arquivo README com as particularidades de cada um. </p>

<!-- Sobre main.tf -->
###### Arquivo main.tf
O arquivo [main.tf](https://github.com/ErikaLBarbosa/infra_kubernetes/blob/main/main.tf) possui cada módulo que será executado e suas variáveis.

<!-- Utilizando o projeto -->

###### Arquivo main.tf
Após clonar o repositório verificar cada módulo e preencher as variáveis com suas informações (acesso a aws), no repositório raiz execute o seguinte comando: 
`terraform apply`