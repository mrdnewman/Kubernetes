#!/usr/bin/env bash

clear

_ns="cert-manager"

echo -e "\nChecking for $_ns namespace ..."
_getNamespace=`kubectl get ns $_ns 2>/dev/null`

if [ $? -eq 0 ]; then
        echo "Nothing to do ... Namespace $_ns exist."
else
        echo "Creating Namespace & Setting label"
        kubectl create namespace $_ns
        kubectl label namespace cert-manager cert-manager.io/disable-validation=true
fi


echo -e "\n Applying CRD's ..."
kubectl apply --validate=false -f \
	https://raw.githubusercontent.com/jetstack/cert-manager/release-0.11/deploy/manifests/00-crds.yaml


echo -e "\nAdd Jetstack Helm Repo"
helm repo add jetstack https://charts.jetstack.io

echo -e "\nUpdating local Helm repo cache"
helm repo update

echo -e "\nInstalling cert-manager Helm Chart now ..."
echo -e "\nInstall the cert-manager Helm chart"
helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.11.0 \
  -f values.yaml \
  jetstack/cert-manager

echo -e "\nChecking Status ..."
_cm_status=`helm ls | grep $_ns | awk '{ print $8 }'`

if [ $_cm_status == DEPLOYED ]; then
        echo "Deployement Successful"
fi




