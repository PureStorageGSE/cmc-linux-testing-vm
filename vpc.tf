#definition of security groups and rules for AWS - access for SSH is tunneled/routed via zScaler proxy

resource "aws_security_group" "allow_ssh_anywhere" {
  name        = "Allow SSH for Pure GSE PS"
  description = "Allow SSH inbound traffic"
  # source  = "terraform-aws-modules/security-group/aws"
  # version = "4.3.0"
  # insert the 3 required variables here
#  vpc_id = aws_vpc.tap-vpc.id

  vpc_id = local.gse_ps_dev_sandbox_vpc_id

  ingress {
    description = "Pure zScaler 1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.161.166.0/23"]
  }

    ingress {
    description = "Pure zScaler 2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.161.142.0/23"]
  }
 
    ingress {
    description = "Pure zScaler 3"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["165.225.198.0/23"]
  }

    ingress {
    description = "Pure zScaler 4"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["165.225.196.0/23"]
  }

    ingress {
    description = "Pure zScaler 5"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.161.224.0/23"]
  }

    ingress {
    description = "Pure zScaler 6"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.161.140.0/23"]
  }

    ingress {
    description = "Pure zScaler 7"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["147.161.144.0/23"]
  }

    ingress {
    description = "Pure zScaler 7"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["165.225.16.0/23"]
  }

     ingress {
    description = "Pure zScaler 8"
    from_port   = 4996
    to_port     = 4996
    protocol    = "tcp"
    cidr_blocks = ["50.202.38.118/32"]
  }

  # ingress {
  #   description = "ICMP from home"
  #   from_port   = -1
  #   to_port     = -1
  #   protocol    = "icmp"
  #   cidr_blocks = ["46.101.51.136/32"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow external access"
  }
}
