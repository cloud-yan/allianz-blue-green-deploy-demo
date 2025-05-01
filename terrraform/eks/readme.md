# AWS EKS and VPC Terraform

This project provisions an AWS Elastic Kubernetes Service (EKS) cluster and Virtual Private Cloud (VPC) infrastructure using Terraform. It leverages reusable Terraform modules for EKS and VPC to simplify deployment and management.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- An S3 bucket and DynamoDB table for remote state management (optional but recommended)

## Usage

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Plan the Infrastructure**:

   ```bash
   terraform plan
   ```

3. **Apply the Configuration**:

   ```bash
   terraform apply
   ```

4. **Destroy the Infrastructure** (when no longer needed):

   ```bash
   terraform destroy
   ```

## Modules Used

### VPC Module

The VPC module is sourced from the [AWS VPC Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-vpc). It creates a VPC with public and private subnets, NAT gateways, and other networking resources.

### EKS Module

The EKS module is sourced from the [AWS EKS Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-eks). It provisions an EKS cluster with managed node groups and optional Fargate profiles.
