resource "aws_launch_template" "eks_nodes" {
  name_prefix = "eks-node-lt-"

  user_data = base64encode(
    templatefile("${path.module}/userdata.sh", {
      CLUSTER_NAME = var.cluster_name
    })
  )
}

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "prod-node-group"
  node_role_arn  = var.node_role_arn
  subnet_ids     = var.subnet_ids

  instance_types = [var.instance_type]

  launch_template {
    id      = aws_launch_template.eks_nodes.id
    version = "$Latest"
  }

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
}
