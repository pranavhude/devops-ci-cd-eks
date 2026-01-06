module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    public_subnets = var.public_subnets
    private_subnets = var.private_subnets
    tags = var.tags
}

module "security_groups" {
    source = "./modules/security-groups"
    vpc_id = modules.vpc.vpc_id
}

module "iam" {
    source = "./modules/eks"
    cluster_name = var.eks_cluster_name
    subnet_ids = module.vpc.private_subnet_ids
    cluster_role_arn = module.iam.eks_cluster_role_arn
}

module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name    = module.eks.cluster_name
  node_role_arn  = module.iam.node_role_arn

  subnet_ids = module.vpc.private_subnet_ids

  desired_size = 2
  min_size     = 1
  max_size     = 3
}

module "jenkins" {
    source        = "./modules/jenkins"
    subnet_id     = module.vpc.public_subnet_ids[0]
    instance_type = var.jenkins_instance_type
    key_name      = var.jenkins_key_name
    sg_id         = module_security_groups.jenkins_sg
    iam_profile   = module.iam.jenkins_instance_profile
    tags          = var.tags
}
