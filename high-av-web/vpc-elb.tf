data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "berg_public_subnet" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "berg_subnet" {
  for_each = data.aws_subnet_ids.berg_public_subnet.ids
  id       = each.value
}

data "aws_ami" "berg_custom_ami" {
  owners = ["self"]
  filter {
    name   = "name"
    values = ["berguiga-custom-ami"]
  }

}