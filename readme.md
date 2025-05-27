# Blue-Green Deployment on AWS EKS with ALB

![AWS EKS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazon-aws)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?logo=kubernetes)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?logo=github-actions)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker)

A implementation of zero-downtime deployments using Blue-Green strategy on Amazon EKS.

## 🌟 Key Features

- **Instant traffic switching** between environments
- **GitHub Actions CI/CD** pipeline
- **ALB-powered** ingress management
- **Health-checked** deployments
- **One-command rollback**

## 🛠️ Prerequisites

- AWS account with EKS permissions
- `kubectl`, `awscli`, `eksctl`, and `helm` installed
- Docker runtime

## 🚀 Demo Infra Setup

### Prerequisites

- AWS CLI installed and configured with proper permissions

- AWS account with permissions to create ECR repositories

- Docker CLI installed

### 1. Cluster Setup

```bash
eksctl create cluster --name demo-cluster --region us-east-1 --node-type t3.medium
```

### 2. ALB Controller Installation

```bash
# 1. Create OIDC provider
eksctl utils associate-iam-oidc-provider \
    --region us-east-1 \
    --cluster demo-cluster \
    --approve

# 2. Create and Attach IAM Policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json

# 3. Create IAM service account
eksctl create iamserviceaccount \
  --cluster=demo-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::<Account-ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

# 4. Install controller
helm repo add eks https://aws.github.io/eks-charts

helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=demo-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller
```

### 3. ECR Setup

1. Create ECR Repo

```bash
aws ecr create-repository \
  --repository-name <your-repo-name> \
  --image-tag-mutability MUTABLE \
  --tags Key=Project,Value=MyApp
```

2. Login to ECR (for later use)

```bash
aws ecr get-login-password | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

### 4. Docker Image Build

1. Blue App (V1)

```dockercommand
docker build -t <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/demo-repo:blue -f ./app/v1/Dockerfile ./app

docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/demo-repo:blue
```

2. Green App (V2)

```dockercommand
docker build -t <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/demo-repo:green -f ./app/v2/Dockerfile ./app

docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/demo-repo:green
```

### 5. Deploy K8s Manifests

```k8s
kubectl apply -f ./k8s/
```

### 4. Configure GitHub Secrets

Set these in your repo settings:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (default: us-east-1)

## 📂 Repository Structure

```folder
.
├── app
│   ├── v1
│   │   ├── Dockerfile
│   │   ├── app.py
│   │   └── requirements.txt
│   └── v2
│       ├── Dockerfile
│       ├── app.py
│       └── requirements.txt
├── k8s
│   ├── alb-ingress-blue.yaml
│   ├── alb-ingress-green.yaml
│   ├── blue-deployment.yaml
│   ├── blue-service.yaml
│   ├── green-deployment.yaml
│   ├── green-service.yaml
│   └── ingress.yaml
├── readme.md
└── terrraform
    │   ├── main.tf
    │   └── outputs.tf
    └── eks
        ├── eks.tf
        ├── outputs.tf
        ├── readme.md
        ├── security_grp.tf
        ├── terraform.tfvars
        ├── variables.tf
        └── vpc.tf
```

## 🔄 Deployment Workflow

1. **Blue Deployment**  
   - Builds and deploys v1 containers
   - Routes 100% traffic to blue

2. **Green Deployment**  
   - Builds v2 containers in parallel
   - Validates new version

3. **Traffic Switch**  

   ```bash
   kubectl apply -f k8s/alb-ingress-green.yaml
   ```

### Rollback

```bash
kubectl apply -f k8s/alb-ingress-blue.yaml
```
