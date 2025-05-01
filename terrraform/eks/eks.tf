locals {
  cluster_name = "eks-${random_string.suffix.result}"
}

module "eks" {
  source          = var.eks_module_source
  version         = var.eks_module_version
  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version
  subnet_ids      = module.vpc.private_subnets
  enable_irsa     = true

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type               = var.eks_ami_type
    instance_types         = var.eks_instance_types
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {

    node_group = {
      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size
    }
  }
}
