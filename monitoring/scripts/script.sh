#!/bin/bash

echo "***************************************************"
echo "*********INICIANDO SCRIPTS DE MONITORING***********"
echo "***************************************************"

#Criando namespace para o prometheus
kubectl create namespace monitoring

#Inserindo e atualizando repo Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

#Deployando helmchats para o namespace criado anteriormente
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring

#Confirmando deployment
sleep 60
kubectl get pods -n monitoring

echo "***************************************************"
echo "*********FINALIZANDO SCRIPTS DE MONITORING*********"
echo "***************************************************"