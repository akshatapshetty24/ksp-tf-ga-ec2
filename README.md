# ksp-tf-ga-ec2

# 🚀 EC2 Provisioning via Terraform & GitHub Actions

This repository provisions an AWS EC2 instance using **Terraform** and automates deployments via **GitHub Actions**.  
It also includes a workflow to safely **destroy only the EC2 instance** to avoid unwanted costs.

---

## 📦 Repo Structure

.
├── .github/
│ └── workflows/
│ ├── terraform-deploy.yml # Deploy EC2 instance
│ └── terraform-destroy-ec2.yml # Destroy EC2 instance only
├── terraform/
│ ├── backend.tf # Remote state backend config
│ ├── main.tf # EC2 instance definition
│ ├── outputs.tf # Terraform outputs
│ ├── variables.tf # Terraform variables
├── .gitignore
└── README.md


---

## 📋 Prerequisites

- An AWS account
- AWS Access Key & Secret Key with permissions for:
  - EC2 provisioning
  - S3 and DynamoDB (for Terraform remote state)
- An existing:
  - EC2 Key Pair name
  - Subnet ID
  - Security Group ID
  - AMI ID (for your region)

---

## 🔐 GitHub Secrets Setup

Go to your **GitHub repository → Settings → Secrets and variables → Actions → New repository secret**  
Add the following secrets:

| Secret Name             | Example Value               |
|:-----------------------|:----------------------------|
| `AWS_ACCESS_KEY_ID`      | `AKIAIOSFODNN7EXAMPLE`        |
| `AWS_SECRET_ACCESS_KEY`  | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `AWS_REGION`             | `ap-south-1`                  |
| `AMI_ID`                 | `ami-0e670eb768a5fc3d4`       |
| `KEY_NAME`               | `my-ec2-keypair`              |
| `SUBNET_ID`              | `subnet-0123456789abcdef0`    |
| `SECURITY_GROUP_ID`      | `sg-0123456789abcdef0`        |

---

## 📝 Remote Terraform State Setup (S3 + DynamoDB)

Before using this repo, create:

1. **S3 bucket** for state storage:
   ```bash
   aws s3api create-bucket --bucket ksp-tf-ga-ec2-state-bucket --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
   aws s3api put-bucket-versioning --bucket ksp-tf-ga-ec2-state-bucket --versioning-configuration Status=Enabled


2. **DynamoDB table** for state locking:

   aws dynamodb create-table \
    --table-name ksp-tf-ga-ec2-lock-table \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region ap-south-1

**🚀 Deploy EC2 Instance**
Go to GitHub → Actions

Select Terraform EC2 Deploy

Click Run workflow

This will:

Initialize Terraform

Plan the changes

Apply the plan and provision an EC2 instance

**🗑️ Destroy EC2 Instance Only**
Go to GitHub → Actions

Select Destroy EC2 Instance Only

Click Run workflow

This will:

Run terraform destroy -target=aws_instance.example

Only destroy the EC2 instance without affecting other resources like the VPC, Security Group, etc.

**📌 Notes**
Ensure your Terraform state is properly initialized before using destroy workflow.

Always verify EC2 instance cost and cleanup unused instances.

Use an IAM user with the least privileges necessary for security.

**🎯 Future Improvements**
Automatic notification on instance creation/destroy (via Slack, email, etc.)

Add cost estimation via Infracost integration

Manage Security Groups & Key Pairs via Terraform too

**📖 **Author****
Made with ❤️ by [Your Name]


---

## ✅ Done!

Would you like me to bundle this README content into a ready-to-use markdown file for you too? Or turn this into a GitHub template repo structure? 👌

