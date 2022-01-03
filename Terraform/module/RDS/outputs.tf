output "db_arn" {
  value = aws_db_instance.DB.arn
}

output "db_dns" {
  value = aws_db_instance.DB.address
}

output "db_id" {
  value = aws_db_instance.DB.id
}