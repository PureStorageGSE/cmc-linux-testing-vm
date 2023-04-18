# working section of code to create vm

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

 // Create "myKey" to AWS!!
resource "aws_key_pair" "kp" {
  key_name   = "CMC_Linux_key"     
  public_key = tls_private_key.pk.public_key_openssh

}

resource "local_file" "CMC_local_key" {
  content = tls_private_key.pk.private_key_pem
  filename = "CMC_Linux_key.pem"
  file_permission = "0600"
}

data "template_file" "user_data" {
  template = file("./volumes.sh")
}
// building dev  vm


resource "aws_eip" "cmc-linux-vm" {
  instance = module.ec2_instance.id
  vpc = true

  tags = {
    "owner" = "cmc-linux-vm"
  }
}

module "ec2_instance" {
  # lines below used for the 'ec2_instance' module which is a couple of years old. 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "linux-cmc-instance"
  availability_zone = local.availability_zone
  ami = data.aws_ami.rhel_8_5.id
  instance_type          = "t3.large"
  key_name               = aws_key_pair.kp.key_name
  monitoring             = true
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_anywhere.id}"]
  subnet_id = local.gse_ps_dev_sandbox_subnet_id

  # subnet_id = aws_subnet.dev.id
  // this causes the user data to get converted into  base64 code to be deposited into the ec2 isntance and can then be executed.
  user_data = data.template_file.user_data.rendered
  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    application = "cmc-linux"
  }
  
}
