MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -euxo pipefail

####################################
# EKS Bootstrap (MANDATORY)
####################################
/etc/eks/bootstrap.sh ${CLUSTER_NAME}

####################################
# Custom Node Setup
####################################
yum install -y git curl jq awscli
sysctl -w net.ipv4.ip_forward=1

--==MYBOUNDARY==--

