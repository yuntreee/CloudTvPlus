
output "dynamodb_name" {
  value = aws_dynamodb_table.sessionDB.id
}