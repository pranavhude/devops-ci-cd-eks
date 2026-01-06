variable "cluster_name" {}
variable "subnet_ids" {}
variable "cluster_role arn" {}

resource "aws_eks_cluster" "this" {
    name  = var.cluster_name
    role_arn  = var.cluster_role_arn

    vpc_config {
        subnet_ids = var.subntes_ids
    }
}
