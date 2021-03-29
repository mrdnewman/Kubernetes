#!/usr/bin/env bash


eksctl create cluster \
--name devops \
--region us-east-2 \
--version 1.14 \
--nodegroup-name devops \
--managed \
--node-type t3.xlarge \
--nodes 3 \
--nodes-min 1 \
--nodes-max 4 \
--ssh-access=true \
--profile stc-one-platform-dev 
