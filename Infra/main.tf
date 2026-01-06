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
    subnets_ids = module.vpc.private_subnets_ids
    cluster_role_arn = module.iam.eks_cluster_role_arn
}

module "nodegroup" {
    source = "./modules/nodegroup"
    cluster_name = module.eks.cluster_name
    subnets_ids  = module.vpc.private_subnets_ids
    node_role_arn = module.iam.eks_node_role_arn
    instance_type = var.node_instance_type
    desired_size  = var.desired_capacity
    min_size      = var.max_capacity
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
