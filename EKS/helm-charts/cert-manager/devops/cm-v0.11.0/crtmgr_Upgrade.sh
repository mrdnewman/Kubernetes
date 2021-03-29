#!/usr/bin/env bash

# ref: https://cert-manager.io/docs/installation/upgrading/

# Backup before upgrading ...
kubectl get -o yaml \
     --all-namespaces \
     issuer,clusterissuer,certificates,certificaterequests > cert-manager-backup.yaml

# Upgrade Cert-Manager ...
helm upgrade --version <version> <release_name> jetstack/cert-manager



