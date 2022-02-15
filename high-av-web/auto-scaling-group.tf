resource "aws_launch_template" "berg_SG_template" {

  name          = "template-scaling-group"
  image_id      = data.aws_ami.berg_custom_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.berg_allow_auto_SG_sg.id]
  
  key_name = "test-amine-berguiga" #TODO make it dynamic

  tag_specifications {
    resource_type = "instance"

    tags = {
      Environment = "dev"
    }
  }
}

resource "aws_autoscaling_group" "berg_autoscaling_group" {
  name                      = "berg-terraform-template"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = [for s in data.aws_subnet.berg_subnet : s.id]
  launch_template {
    id      = aws_launch_template.berg_SG_template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.berg_alb_target_group.arn]
}