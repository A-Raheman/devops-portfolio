output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_az1_id" {
  value = aws_subnet.public_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_az2.id
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}

output "web1_public_ip" {
  value = aws_instance.web1.public_ip
}

output "web2_public_ip" {
  value = aws_instance.web2.public_ip
}

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
