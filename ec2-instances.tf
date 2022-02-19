resource "aws_instance" "traccar_web" {
  ami                  = var.traccar_web_ami
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnets.subnets.ids[0]
  security_groups      = [aws_security_group.allow_trac_web.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.id

  tags = {
    Name = "traccar-web"
  }
}

resource "aws_instance" "traccar_db" {
  ami                  = var.traccar_db_ami
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnets.subnets.ids[0]
  private_ip           = var.db_static_ip
  security_groups      = [aws_security_group.allow_trac_db.id]
  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.id

  tags = {
    Name = "traccar-db"
  }

  depends_on = [
    aws_security_group.allow_trac_web
  ]
}

resource "aws_security_group" "allow_trac_web" {
  name        = var.sg_allow_trac_web
  description = var.sg_allow_trac_db_desc
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "Web from VPC"
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_trac_web"
  }
}

resource "aws_security_group" "allow_trac_db" {
  name        = var.sg_allow_trac_db
  description = var.sg_allow_trac_db_desc
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description     = "DB from VPC"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_trac_web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_trac_db"
  }

  depends_on = [aws_security_group.allow_trac_web]
}