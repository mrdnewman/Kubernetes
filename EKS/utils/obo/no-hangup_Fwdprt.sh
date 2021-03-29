#!/usr/bin/env bash

#================================================================================
#title           :fwdprt-eks_Dash.sh
#description     :This script executes fwdprt-eks_Dash.sh under nohup status.
#                :This allows shell to be closed w/o interupping port forwarding
#
#author          :D. Newman
#date            :7/5/2019
#version         :0.1
#notes           :N/A
#================================================================================


nohup sh ./fwdprt-eks_Dash.sh &>/dev/null
