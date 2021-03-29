#!/usr/bin/env bash


helm install stable/kube2iam \
	--name kube2iam --namespace kube2iam -f values.yaml
