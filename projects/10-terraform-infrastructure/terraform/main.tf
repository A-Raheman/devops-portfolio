resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH and app access"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Application access"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name     = "${var.project_name}-sg"
    Project  = var.project_name
  }
}

resource "aws_instance" "web_server" {
  ami			 = var.ami_id
  instance_type		 = var.instance_type
  key_name		 = var.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name    = "${var.project_name}-ec2"
    Project = var.project_name
  }
}

