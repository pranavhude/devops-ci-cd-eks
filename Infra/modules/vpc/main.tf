resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    tags       = var.tags
}

resource "aws_subnet" "public" {
    count    = length(var.public_subnets)
    vpc_id   = aws_vpc.this.vpc_id
    cidr_block = var.public_subnets[count.index]
    availabilty_zone = element(["ap-south-1a","ap-south-1b"], count.index)
    map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(["ap-south-1a","ap-south-1b"], count.index)
}