region       = "ap-south-1"
project_name = "prod-devops-platform"
environment  = "production"

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

jenkins_instance_type = "t3.medium"
jenkins_key_name      = "prod-keypair"

eks_cluster_name   = "prod-eks-cluster"
node_instance_type = "t3.small"
desired_capacity   = 2
min_capacity       = 1
max_capacity       = 3

tags = {
  Project     = "CI-CD-EKS"
  Environment = "Production"
  Owner       = "DevOps"
}
