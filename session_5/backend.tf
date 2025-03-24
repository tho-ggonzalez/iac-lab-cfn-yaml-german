terraform {
  backend "s3" {
    bucket = "gg-iac-lab-tfstate"
    key    = "terraform/state"
    region = "eu-central-1"

    dynamodb_table = "gg-iac-lab-tfstate-locks"
    encrypt        = true
  }
}