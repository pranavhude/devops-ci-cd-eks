variable  "region" {}
variable  "project_name" {}
variable  "enviornment"{}

variable "vpc_cidr" {}
variable "public_subnets" {
    type = list(string)
}
variable "private_subnets" {
    type = list(string)
}

variable "jenkins_instance_type" {}
variable "jenkins_key_name" {}

variable "eks_cluster_name" {}
variable "node_instance_type" {}
variable "desired_capacity" {}
variable "min_capacity" {}
variable "max_capacity" {}

variable "tags" {
    type  = map(string)
}