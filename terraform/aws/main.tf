terraform {
  required_version = "~> 1.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.50"
    }
  }
}

# data "aws_ami" "this" {
#   most_recent = true

#   filter {
#     name = "architecture"
#     values = ["x86_64"]
#   }

#   filter {
#     name = "name"
#     values = ["amazon-eks-node-1.25-*"]
#   }

#   filter {
#     name = "root-device-type"
#     values = ["ebs"]
#   }


#   filter {
#     name = "state"
#     values = ["available"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = [
#     var.ami_owner
#   ]
# }

data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "this" {
  key_name = "iuri-local"
  public_key = file("/home/iuri/.ssh/aws_rsa.pub")
}

resource "aws_security_group" "this" {
  name = "Allow SSH"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.this.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.this.key_name
  security_groups = ["${aws_security_group.this.name}"]

  tags = {
    Name = "Kubernetes cluster node"
    Type = "Self managed"
  }
}

output "instance_public_ip" {
  value = aws_instance.this.public_ip
}

output "instance_public_dns" {
  value = aws_instance.this.public_dns
}
