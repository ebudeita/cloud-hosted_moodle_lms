output "moodle_url" {
  description = "Public URL for the Moodle server."
  value       = "http://${aws_instance.moodle.public_dns}"
}

output "ec2_public_ip" {
  description = "Public IP address of the Moodle server."
  value       = aws_instance.moodle.public_ip
}

output "ssh_command" {
  description = "Example SSH command."
  value       = "ssh -i ~/.ssh/${var.key_name}.pem ubuntu@${aws_instance.moodle.public_ip}"
}

output "database_endpoint" {
  description = "RDS MySQL endpoint."
  value       = aws_db_instance.moodle.address
}

output "database_name" {
  description = "Moodle database name."
  value       = var.db_name
}

output "database_username" {
  description = "Moodle database username."
  value       = var.db_username
}

output "database_password" {
  description = "Generated Moodle database password."
  value       = random_password.database.result
  sensitive   = true
}
