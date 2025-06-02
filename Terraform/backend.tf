terraform {
  backend "s3" {
    bucket = "malak-eks-terraform-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true 
  }
} 