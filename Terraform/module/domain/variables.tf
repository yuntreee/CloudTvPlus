# 도메인 네임
variable "domain_name" {}

variable "lb_arn" {
  type = list(string)
  default = []
}