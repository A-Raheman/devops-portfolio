output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

output "ec2_instance_id" {
  value = aws_instance.web.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}
