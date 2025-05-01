variable "aws_region" {
  description = "The AWS region to deploy the resources in"
  type        = string
}

variable "random_string_length" {
  description = "The length of the random string suffix for the cluster name"
  type        = number
}

variable "vpc_module_source" {
  description = "The source of the VPC module"
  type        = string
}

variable "vpc_module_version" {
  description = "The version of the VPC module"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "Use a single NAT Gateway"
  type        = bool
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
}

variable "vpc_enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
}

variable "eks_module_source" {
  description = "The source of the EKS module"
  type        = string
}

variable "eks_module_version" {
  description = "The version of the EKS module"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "eks_ami_type" {
  description = "The AMI type for the EKS nodes"
  type        = string
}

variable "eks_instance_types" {
  description = "The instance types for the EKS nodes"
  type        = list(string)
}

variable "node_group_min_size" {
  description = "The minimum size of the node group"
  type        = number
}

variable "node_group_max_size" {
  description = "The maximum size of the node group"
  type        = number
}

variable "node_group_desired_size" {
  description = "The desired size of the node group"
  type        = number
}

variable "sg_ingress_cidr_blocks" {
  description = "The CIDR blocks for ingress rules"
  type        = list(string)
}

variable "sg_outbound_cidr_blocks" {
  description = "The CIDR blocks for outbound rules"
  type        = list(string)
}