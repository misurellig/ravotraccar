data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "subnet" {
  id = data.aws_subnets.subnets.ids[0]
}

data "aws_ami" "ravotraccar" {
  most_recent = true
  owners      = var.ami_owners
  name_regex  = var.ami_name
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}