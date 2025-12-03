resource "aws_launch_template" "nginx" {
  name          = "nginx-template"
  image_id      = "ami-0ff3ffae254f9ede6"
  instance_type = var.ec2_instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  vpc_security_group_ids = [aws_security_group.ec2.id, aws_security_group.alb_sg.id]

  user_data = filebase64("${path.module}/scripts/nginx")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "nginx-instance"
    }
  }
}

resource "aws_autoscaling_group" "nginx" {
  name                = "nginx-asg"
  vpc_zone_identifier = var.private_subnets

  min_size         = 1
  max_size         = 2
  desired_capacity = 2

  health_check_type         = "EC2"
  health_check_grace_period = 300
  default_cooldown          = 300

  target_group_arns = [aws_lb_target_group.nginx_tg.arn]

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "nginx-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "AutoHealing"
    value               = "enabled"
    propagate_at_launch = true
  }
}
