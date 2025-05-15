terraform {
  backend "s3" {
    bucket         = "ksp-tf-ga-ec2-state-bucket"
    key            = "ec2/github-actions/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "ksp-tf-ga-ec2-lock-table"
    encrypt        = true
  }
}
