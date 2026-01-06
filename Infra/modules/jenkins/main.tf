variable "subnet_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "sg_id" {}
variable "iam_profile" {}
variable "tags" {}

resource "aws_instance" "this" {
  ami                    = "ami-0f5ee92e2d63afc18" # Amazon Linux 2023
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  iam_instance_profile   = var.iam_profile

  user_data = file("${path.module}/userdata.sh")

  tags = var.tags
}
