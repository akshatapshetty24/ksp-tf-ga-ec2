terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "ec2/github-actions/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
