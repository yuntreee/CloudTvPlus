

resource "aws_dynamodb_table" "sessionDB" {
  name = "ctp-usersession-${var.region_name}-${var.account_id}"
  read_capacity  = 10
  write_capacity = 10
  hash_key = "id"
  attribute {
    name = "id"
    type = "S"
  }
}

# VPC-DynamoDB 엔드포인트 게이트웨이
resource "aws_vpc_endpoint" "dynamodb_endpoint" {
  service_name = "com.amazonaws.${var.region}.dynamodb"
  vpc_id = var.vpc_id
  route_table_ids = [
    var.pub_RT,
    var.pri_RT1,
    var.pri_RT2
  ]
}