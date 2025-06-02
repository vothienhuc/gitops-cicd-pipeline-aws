terraform {
  backend "s3" {
    bucket = "salma-terraform-statefile"
    key = "terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true 
  }
} 