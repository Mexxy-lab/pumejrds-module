#outputs.tf
output "subnet_id" {
  value = aws_subnet.priv_one.id
}
output "db_instance_endpoint" {
  value = aws_db_instance.pumejrds-instance.endpoint
}