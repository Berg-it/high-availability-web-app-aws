resource "aws_ami_from_instance" "example" {
  name               = "berguiga-custom-ami"
  source_instance_id = "i-0e937552d2faae995"
}