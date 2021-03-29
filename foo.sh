#!/usr/bin/env bash


eksctl create nodegroup \
	--cluster devops \
	--version 1.15 \
	--name devops-ng3 \
	--node-type t3.xlarge \
	--nodes 3 \
	--nodes-min 1 \
	--nodes-max 4 \
	--node-ami auto
