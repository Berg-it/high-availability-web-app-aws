resource "aws_security_group" "berg_allow_auto_SG_sg" {
  name        = "berguiga-auto-scaling-group"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  # allow ingress of port 22
  ingress {
    security_groups = [aws_security_group.berg_allow_elb_sg.id]
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
  }

  # allow ingress port 80 
  ingress {
    security_groups = [aws_security_group.berg_allow_elb_sg.id]
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
  }

  ingress {
    security_groups = [aws_security_group.berg_allow_elb_sg.id]
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
  }

  #   egress {
  #       from_port        = 0
  #       to_port          = 0
  #       protocol         = "-1"
  #       security_groups       = aws_security_group.berg_allow_elb_sg.name
  #       ipv6_security_groups  = ["::/0"]
  #     }  

  tags = {
    Environment = "dev"
  }
}
