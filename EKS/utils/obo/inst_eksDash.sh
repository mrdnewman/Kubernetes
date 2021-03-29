#!/usr/bin/env bash

#==============================================================================
#title           :eks-dash_Inst.sh
#description     :This script installs Kubernetes Dash Board
#author          :D. Newman
#date            :7/5/2019
#version         :0.1
#notes           :N/A
#==============================================================================


clear
echo -e "\n\n\t\t\t\t<> Starting Kubernetes Dash Board Install <>\n\n"

evalAction () {

	[ $? -eq 0 ] && echo -e "\n* Successfully Installed ...\n\n" \
		|| (echo -e "<> Failed ...\n\n"; exit 1)
}


for i in Dashboard Heapster Influxdb Heapster-role svc-account #Token
do
   case $i in
        Dashboard)
	
	(echo -e "\n<> Deploying [ ${i} ] ...\n"; sleep 1)

	kubectl delete -f \
	https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml \
	#https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-rc6/aio/deploy/recommended.yaml \


	evalAction

        ;;

        Heapster)

	(echo -e "\n<> Deploying [ ${i} ] -- Enaables container cluster monitoring & performance on Cluster ...\n"; sleep 1)

	kubectl delete -f \
	https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml \
	

	evalAction

        ;;

        Influxdb)
	
	(echo -e "\n<> Deploying [ ${i} ] -- backend to Heapster on Cluster ...\n"; sleep 1)

	kubectl delete -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml \
	

	evalAction

        ;;

        Heapster-role)

	(echo -e "\n<> Deploying [ ${i} ] -- Creates and binds Cluster Role to Dashboard ...\n"; sleep 1)

	kubectl delete -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml \
	

        evalAction

        ;;

        svc-account)

	(echo -e "\n<> Deploying [ ${i} ] -- Applies Svc Account & Cluster Role Binding On Cluster ...\n"; sleep 1)

	[ ! -f eks-admin-service-account.yaml ] && (echo -e "Your Service account file is missing!"; exit 1) 

	kubectl delete -f eks-admin-service-account.yaml
	kubectl create clusterrolebinding kubernetes-dashboard --clusterrole=cluster-admin --serviceaccount=kube-system:kubernetes-dashboard

	evalAction

	;;

	Token)

	(echo -e "\n<> Retrieving Authentication [ ${i} ] ...\n"; sleep 1)

	kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kubernetes-dashboard-token | awk '{print $1}')

	evalAction

        ;;
   esac

done


cat <<EOF
1.) Right-Click on link below
2.) Choose "Open Link" to access Kube Dashboard
----------------------------------------------------------------------------------------------------------
http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login
----------------------------------------------------------------------------------------------------------
3.) Your browser should spring open with Kube Console -- Choose \"Token\" on console and paste token string from above
EOF

#echo -e "\n\n<> Starting Kubectl Proxy -- Hit return Please ...\n"
#kubectl proxy &



