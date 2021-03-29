#!/usr/bin/env bash

# Tile: k8s_dashboard.sh
# Desc: This script installs|deletes kubernetes dashboard environment
#       and service account.
# Date: 3/18/2020
# Vers: 0.1 
# 
#
#
# Args: None
#
# Notes:
#   Decision to install/delete are based on the EXISTENCE of the "kubernetes-dashboard"
#   namespace. 
#   
#   
#
# Authors:
#   David Newman <david_newman@stchome.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


clear
set -e 

usage="USAGE: ./k8s_dashboard.sh <--install>|<--delete>"
name_space=`kubectl get ns | grep kubernetes-dashboard | awk '{ print $1 }'`

echo -e "\n\n\t\t\t\t<> Kubernetes Dashboard <>\n\n"


case $1 in 
   --install )

	      [[ "$name_space" = kubernetes-dashboard ]] && echo -e "\nNothing to do ...\n" && exit 1

              echo -e "-- Deploying Dashboard UI ...\n"
              kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

              echo -e "\n-- Deploying Dashboard Service Account ..."
              kubectl apply -f dashboard_svc-acct.yaml

	      echo -e "\n\n\t\t\t\t Components Installed ... \n\n"

	      ;;

   --delete )

              [[ -z "$name_space" ]] && echo -e "\nNothing to do ...\n" && exit 1

	      echo -e "\n-- Deleting Dashboard Service Account ...\n"
              kubectl delete -f dashboard_svc-acct.yaml

	      echo -e "\n-- Deleting Dashboard UI ...\n"
              kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml

	      echo -e "\n\n\t\t\t\t Components Removed ... \n\n"

	      ;;


          * )
              echo "${usage}" && exit 1
	      
	      ;;
esac





