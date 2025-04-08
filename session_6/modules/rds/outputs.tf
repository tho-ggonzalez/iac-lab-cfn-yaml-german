output "rds_address" {
  description = "The address of the RDS instance."
  value       = aws_db_instance.database.address
}