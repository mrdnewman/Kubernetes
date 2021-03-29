#!/usr/bin/env bash

# Desc: k8s_direct-connect.sh script starts or refreshes kubernetes proxy PID, makes a connecton 
#       to Kubernetes Dashboard from local host, delivers Dashboard page and login token. The
#       Kubernetes control node is not relevant here. 
# 
#
#
# Args: None
#
# Notes:
#   Failure to refresh the Kuberneted Proxy PID results in An Unauthorized (401) error after switching 
#   context over to another cluster environment. 
#
#   Also insure to logout of Dashboard before switching context over to use another. Failure to do so will 
#   also reault in error and denided access to the console. 
#   
#
# Authors:
#   David Newman <david_newman@stchome.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

_dash_brow="http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"


cleanup() {
    err=$?
    echo "Cleaning stuff up..."
    trap '' EXIT INT TERM
    exit $err
}

sig_cleanup() {
    trap '' EXIT # some shells will call EXIT after the INT handler
    false # sets $?
    cleanup
}


# refresh kubernetes proxy
ps -eaf | grep kubectl | grep -v grep | awk '{print $2}' | xargs kill &>/dev/null
kubectl proxy & &>/dev/null


trap cleanup EXIT
trap sig_cleanup INT QUIT TERM

sleep 2
echo opening browser...

# open a browser
xdg-open ${_dash_brow} > /dev/null 2> /dev/null

# get token
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
