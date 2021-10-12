module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tap-dev-vpc"
  cidr = "10.98.0.0/16"

  azs             = ["eu-west-2a"]
  private_subnets = ["10.98.1.0/24"]
  public_subnets  = ["10.98.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}



resource "aws_security_group" "allow_ssh_anywhere" {
  name        = "Allow SSH"
  description = "Allow SSH inbound traffic"
  #  source  = "terraform-aws-modules/security-group/aws"
  #  version = "4.3.0"
  # insert the 3 required variables here

  ingress {
    description = "ssh from internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow public ssh access"
  }
}
