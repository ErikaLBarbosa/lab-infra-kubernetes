#!/bin/bash
# Autor: Erika Barbosa
# Descrição: Realizar o update da ec2 (amazon linux), fazer configurações pré-rec para utilizar o kubernetes,
# instalar -> Kubamd, Kubelet, Kubectl, Helm

echo "***************************************************"
echo "*******INICIANDO A CONFIGURAÇÃO DA MÁQUINA*********"
echo "***************************************************"

echo "VERIFICANDO SE OS ARQUIVOS FORAM CRIADOS"
ls -la /tmp/arquivos_config

#Update#
sudo yum update -y

#Desabilitar o swap
sudo swapoff -a

#Habilitar modulos Recomendados pela Doc do Kubernetes#
sudo modprobe overlay
sudo modprobe br_netfilter
sudo cp /tmp/arquivos_config/containerd.conf /etc/modules-load.d/containerd.conf
cat /etc/modules-load.d/containerd.conf

#Adicionar configs no sysctl
sudo cp /tmp/arquivos_config/99-kubernetes-cri.conf /etc/sysctl.d/99-kubernetes-cri.conf
sudo sysctl --system

#Instalação do Docker#
sleep 60
sudo yum install docker -yq
sudo usermod -a -G docker ec2-user
sudo pip3 install docker-compose
sudo systemctl enable docker.service
sudo systemctl start docker.service

#Instalar e configurar container runtime - containerd
sudo yum install -y containerd
sudo mkdir -p /etc/containerd
sudo rm /etc/containerd/config.toml
sudo cp /tmp/arquivos_config/config.toml /etc/containerd/config.toml
cat /etc/containerd/config.toml
sudo systemctl restart containerd

#Instalação Kubamd, Kubelet, Kubectl#
sudo cp /tmp/arquivos_config/kubernetes.repo /etc/yum.repos.d/kubernetes.repo
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
sudo systemctl start kubelet
cd .. && cd .. && pwd
mkdir /tmp/arquivos_config/kubernetes
mkdir /tmp/arquivos_config/kubefiles
cd /tmp/arquivos_config/kubernetes && ls -la
mkdir -p /tmp/arquivos_config/docker

#Evitando possível error timeout
sudo cp /tmp/arquivos_config/docker/daemon.json /etc/docker/daemon.json
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo cp /tmp/arquivos_config/docker/docker.conf /etc/systemd/system/docker.service.d/docker.conf
sudo systemctl daemon-reload
sudo systemctl restart docker

#Instalando Helm
echo "INSTALANDO HELM"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "***************************************************"
echo "*****************FINAL DO SCRIPT*******************"
echo "***************************************************"
