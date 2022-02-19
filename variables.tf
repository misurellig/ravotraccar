variable "aws_region" {
  type = string
}

variable "trac_db_app_pwd" {
  type = string
}

variable "trac_db_root_pwd" {
  type = string
}

variable "trac_db_app_pwd_v" {
  type = string
}

variable "trac_db_root_pwd_v" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "traccar_web_ami" {
  type = string
}

variable "traccar_db_ami" {
  type = string
}

variable "sg_allow_trac_web" {
  type = string
}

variable "sg_allow_trac_web_desc" {
  type = string
}

variable "sg_allow_trac_db" {
  type = string
}

variable "sg_allow_trac_db_desc" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_static_ip" {
  type = string
}
variable "ami_owners" {
  type = list(any)
}

variable "ami_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "db_data_size" {
  type = number
}
