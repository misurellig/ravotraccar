output "subnet_id" {
  value = data.aws_subnets.subnets.ids[0]
}

output "subnet_az" {
  value = data.aws_subnet.subnet.availability_zone
}

output "traccar_web_instance_id" {
  value = aws_instance.traccar_web.id
}

output "traccar_web_instance_public_dns" {
  value = aws_instance.traccar_web.public_dns
}

output "traccar_db_instance_id" {
  value = aws_instance.traccar_db.id
}

output "traccar_db_instance_public_dns" {
  value = aws_instance.traccar_db.public_dns
}