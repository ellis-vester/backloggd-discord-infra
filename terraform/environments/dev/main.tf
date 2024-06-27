data "aws_ami" "nixos_x86_64" {
  owners      = ["427812963091"]
  most_recent = true

  filter {
    name   = "name"
    values = ["nixos/24.05*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "nixos_x86_64" {
  ami           = "ami-072b8d13c5fe22307"
  instance_type = "t3a.small"
  key_name      = "test"
  associate_public_ip_address = true

  subnet_id              = "subnet-088fa3a3215bfeb4a"
  vpc_security_group_ids = [aws_security_group.allow_ssh_in.id]
}

resource "aws_security_group" "allow_ssh_in" {
  name   = "allow_ssh_in"
  vpc_id = "vpc-0e07cd624fe19214f"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
