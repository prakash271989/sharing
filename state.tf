terraform {
  backend "s3" {
    bucket         = "statefilestore"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "us-east-1"
    dynamodb_table = "locktable"
  }
}