#!/usr/bin/env bash

# Helm chart install for "stc-002" cluster and relegated to hostedzone "hostk8s3.com"

helm install --name external-dns \
  --namespace external-dns \
  --set provider=aws \
  --set aws.region=us-east-2 \
  --set aws.zoneType=public \
  --set logLevel=debug \
  --set rbac.create=true \
  --set aws.credentials.accessKey=<access_keys_here> \
  --set aws.credentials.secretKey=<access_keys_here> \
  --set txtOwnerId=Z06641141XN8DYX4VRXIY \
  --set domainFilters[0]=hostk8s3.com \
  -f values.yaml \
  bitnami/external-dns

