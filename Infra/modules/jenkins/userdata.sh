#!/bin/bash
set -euxo pipefail

#################################
# OS Update
#################################
dnf update -y

#################################
# Java (Jenkins requirement)
#################################
dnf install -y java-17-amazon-corretto

#################################
# Git (SCM)
#################################
dnf install -y git

#################################
# Jenkins
#################################
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins
systemctl enable jenkins
systemctl start jenkins

#################################
# Docker
#################################
dnf install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker jenkins

#################################
# kubectl (EKS)
#################################
curl -o /usr/local/bin/kubectl \
https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

#################################
# Restart Jenkins
#################################
systemctl restart jenkins
