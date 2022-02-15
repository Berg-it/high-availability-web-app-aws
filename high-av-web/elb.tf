resource "aws_lb" "berg_alb" {
  name               = "berg-alb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.berg_allow_elb_sg.id]
  subnets            = [for s in data.aws_subnet.berg_subnet : s.id]

  enable_deletion_protection = true

  tags = {
    Environment = "dev"
  }
}

#Provides a Target Group resource for use with Load Balancer resources.
resource "aws_lb_target_group" "berg_alb_target_group" {
  name     = "web-server-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path = "/"
    port = 80
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.berg_alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.berg_alb_target_group.arn
  }
}

