#-------------------- EC2 Auto Scaling --------------------#
# 시작구성
resource "aws_launch_configuration" "ctp-alc" {
    image_id = var.image_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.instance.id]
    iam_instance_profile = "${aws_iam_instance_profile.instance-profile.name}"

    user_data = <<-EOF
                #! /bin/bash
                echo 'ubuntu:ubuntu' | sudo chpasswd
                sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
                service sshd restart

                apt-get -y install nfs-common portmap
                mkdir /var/www/html/data
                
                sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.id}.efs.ap-northeast-2.amazonaws.com:/ /var/www/html/data
                sudo chmod 0777 /var/www/html/data
                
                echo "SetEnv DB_read ${var.db_dns_read}" >> /etc/apache2/apache2.conf
                echo "SetEnv DB_write ${var.db_dns_write}" >> /etc/apache2/apache2.conf
                echo "SetEnv REGION ${var.region}" >> /etc/apache2/apache2.conf
                echo "SetEnv DYNAMODB ${var.dynamodb_name}" >> /etc/apache2/apache2.conf
                
                EOF

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "ctp-asg" {

    launch_configuration = aws_launch_configuration.ctp-alc.name
    #vpc_zone_identifier = ["${aws_subnet.private_subnet_a.id}", "${aws_subnet.private_subnet_c.id}"]
    vpc_zone_identifier = [
      var.pri_subnet_a,
      var.pri_subnet_c
    ]
    target_group_arns = [aws_lb_target_group.asg.arn]
    health_check_type = "ELB"

    min_size = 2
    max_size = 10

    tag {
        key = "Name"
        value = "ctp-asg-${var.region_name}"
        propagate_at_launch = true
    }
}

# Scale Out 알람, 5분동안 평균cpu사용률 60%이상이면 울림
resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name = "scale-out-alarm-${var.region_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "60"
  alarm_actions = [aws_autoscaling_policy.scale_out_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ctp-asg.name
  }
}

# 60~75면 1개 증가, 75이상이면 2개 증가
resource "aws_autoscaling_policy" "scale_out_policy" {
  name = "scale-out-policy-${var.region_name}"
  adjustment_type = "ChangeInCapacity"
  policy_type = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.ctp-asg.name

  step_adjustment {
    scaling_adjustment = 1
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 15
  }
  step_adjustment {
    scaling_adjustment = 2
    metric_interval_lower_bound = 15
  }
}

# Scale In 알람, 5분동안 평균cpu사용률 20% 미만이면 울림
resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name = "scale-in-alarm-${var.region_name}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "20"
  alarm_actions = [aws_autoscaling_policy.scale_in_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ctp-asg.name
  }
}

# 1개 감소
resource "aws_autoscaling_policy" "scale_in_policy" {
  name = "scale-in-policy-${var.region_name}"
  adjustment_type = "ChangeInCapacity"
  policy_type = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.ctp-asg.name

  step_adjustment {
    scaling_adjustment = -1
    metric_interval_upper_bound = 0
  }
}

# ------------------- ALB ---------------------#
resource "aws_lb" "ctplb" {
    name = "ctp-lb-${var.region_name}"
    load_balancer_type = "application"
    internal = false
    subnets = [
        var.pub_subnet_a,
        var.pub_subnet_c
    ]
    security_groups = [aws_security_group.lb-sg.id]
}

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.ctplb.arn
    port = 443
    protocol = "HTTPS"
    certificate_arn = var.acm_certificate
    ssl_policy = "ELBSecurityPolicy-2016-08"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code = 404
        }
    }
}


resource "aws_lb_target_group" "asg" {

    name = "ctp-asg-${var.region_name}"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        path = "/"
        protocol = "HTTP"
        matcher = "200"
        interval = 15
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 5
    }
}

resource "aws_lb_listener_rule" "asgrule" {
    listener_arn = aws_lb_listener.https.arn
    priority = 100

    condition {
        path_pattern {
            values = ["*"]
        }
    }

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.asg.arn
    }
}