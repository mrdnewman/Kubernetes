#!/usr/bin/env bash

helm install \
	--name nginx-ingress \
	--namespace nginx-ingress \
	-f values.yaml \
	stable/nginx-ingress

