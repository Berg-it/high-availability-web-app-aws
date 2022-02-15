resource "aws_security_group" "allow_tls" {
  name        = "berguiga-sg-01"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  # allow ingress of port 22
  ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # allow ingress port 80 
  ingress {
    cidr_blocks = var.ingressCIDRblock
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

    ingress {
    cidr_blocks = var.ingressCIDRblock
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = var.ingressCIDRblock
      ipv6_cidr_blocks = ["::/0"]
    }  

  tags = {
    Name = "allow_tls"
  }
}
