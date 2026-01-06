################################
# VPC
################################
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  tags           = var.tags
}

################################
# SECURITY GROUPS
################################
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id = module.vpc.vpc_id
}

################################
# IAM
################################
module "iam" {
  source = "./modules/iam"
}

################################
# EKS CLUSTER
################################
module "eks" {
  source = "./modules/eks"

  cluster_name     = var.eks_cluster_name
  subnet_ids       = module.vpc.private_subnet_ids
  cluster_role_arn = module.iam.cluster_role_arn
}

################################
# NODE GROUP
################################
module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name   = module.eks.cluster_name
  node_role_arn = module.iam.node_role_arn
  subnet_ids     = module.vpc.private_subnet_ids
  
  instance_type = "t3.medium"

  desired_size = 2
  min_size     = 1
  max_size     = 3
}

################################
# JENKINS
################################
module "jenkins" {
  source        = "./modules/jenkins"

  subnet_id     = module.vpc.public_subnet_ids[0]
  instance_type = var.jenkins_instance_type
  key_name      = var.jenkins_key_name
  sg_id         = module.security_groups.jenkins_sg
  iam_profile   = module.iam.jenkins_instance_profile
  tags          = var.tags
}
