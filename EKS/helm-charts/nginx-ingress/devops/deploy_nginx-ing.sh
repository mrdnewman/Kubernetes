#!/usr/bin/env bash


helm install stable/nginx-ingress \
	--name nginx-ingress --namespace nginx-ingress -f values.yaml
