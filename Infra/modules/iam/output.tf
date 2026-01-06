output "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  value       = aws_iam_role.eks_cluster.arn
}

output "node_role_arn" {
  description = "IAM role ARN for EKS worker nodes"
  value       = aws_iam_role.eks_node.arn
}

output "jenkins_instance_profile" {
  description = "Instance profile name for Jenkins EC2"
  value       = aws_iam_instance_profile.jenkins.name
}
