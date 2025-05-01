aws_region = "us-east-1"

random_string_length = 6

vpc_module_source        = "terraform-aws-modules/vpc/aws"
vpc_module_version       = "5.21.0"
vpc_name                 = "eks-terrafrom-demo-vpc"
vpc_cidr                 = "10.0.0.0/16"
vpc_private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
vpc_public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
vpc_enable_dns_hostnames = true
vpc_enable_dns_support   = true
vpc_single_nat_gateway   = true


eks_module_source       = "terraform-aws-modules/eks/aws"
eks_module_version      = "20.36.0"
cluster_version         = "1.32"
eks_ami_type            = "AL2_x86_64"
eks_instance_types      = ["t3.medium"]
node_group_min_size     = 2
node_group_max_size     = 4
node_group_desired_size = 2


sg_ingress_cidr_blocks = ["10.0.0.0/8"]
sg_outbound_cidr_blocks = ["0.0.0.0/0"]