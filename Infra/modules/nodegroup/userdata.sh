#!/bin/bash
set -ex

# EKS Bootstrap (Mandatory)
/etc/eks/bootstrap.sh $(CLUSTER_NAME)

#Custom Node Setup (Optional)

#Install common tools
yum install -y git curl jq awscli

# Optional : enable IP forwarding (safe default)

sysctl -w net.ipv4.ip_forward=1

