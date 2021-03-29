#!/usr/bin/env bash

# Helm chart install for "devops" cluster and relegated to hostedzone "hostk8s2.com"

helm install --name external-dns \
  --namespace external-dns \
  --set provider=aws \
  --set aws.region=us-east-2 \
  --set aws.zoneType=public \
  --set logLevel=debug \
  --set rbac.create=true \
  --set aws.credentials.accessKey=<access_key_here> \
  --set aws.credentials.secretKey=<access_key_here> \
  --set txtOwnerId=ZDCLZUXVVE8JX \
  --set domainFilters[0]=hostk8s2.com \
  -f values.yaml \
  bitnami/external-dns

