#!/usr/bin/env bash


helm install svc-cat/catalog \
       --name catalog \
       --namespace catalog \
       --set rbacEnable=false \
       --set apiserver.storage.etcd.persistence.enabled=true \
       --set apiserver.healthcheck.enabled=false \
       --set controllerManager.healthcheck.enabled=false \
       --set apiserver.verbosity=2 \
       --set controllerManager.verbosity=2 
