terraform {
  backend "s3" {
    bucket         = "8934575-tfstate"
    key            = "terraform/state"
    region         = "us-east-1"
  }
}