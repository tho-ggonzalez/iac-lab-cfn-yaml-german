locals {
  number_of_public_subnets  = 2
  number_of_private_subnets = 2
  number_of_secure_subnets  = 2

  db_secret_arn    = "arn:aws:secretsmanager:eu-central-1:160071257600:secret:dev/dbgg-EuMWhn"
  db_secret_key_id = "aws/secretsmanager"
}