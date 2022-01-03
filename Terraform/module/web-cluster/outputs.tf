# 오토스케일링 그룹 이름
output "autoscaling_group_name" {
  description = "Name of autoscaling group ctp-asg"
  value       = aws_autoscaling_group.ctp-asg.name
}


# ALB 타겟 그룹 이름
output "alb_target_group_name" {
  description = "Name of alb target group ctplb"
  value       = aws_lb.ctplb.name
}

output "alb_arn" {
  value = aws_lb.ctplb.arn
}


output "s3_full_access" {
  value = data.aws_iam_policy.S3FullAccess.arn
}

output "instance_sg" {
  value = aws_security_group.instance.id
}

output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "lb_arn" {
  value = aws_lb.ctplb.arn
}