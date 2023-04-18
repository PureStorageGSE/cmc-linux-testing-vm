output "dev-vpc-sg" {
  value = aws_security_group.allow_ssh_anywhere.id
}

output "instance-id" {
  value = module.ec2_instance.id
 
}

output "private-ip" {
 value = module.ec2_instance.private_ip

}

output "public-ip" {
   value = module.ec2_instance.public_ip


}

output "Elastic-IP" {
  value = aws_eip.cmc-linux-vm.public_dns
  
}

# output "EIP-for-vm" {
#   value = aws_eip.cmc-linux-vm.public_ip
# }

# output "EIP-dns" {
#   value = module.ec2_instance.aws_eip.public_dns
#   #  aws_eip.public_dns
# }

# output "ebs_volume_id" {

# value = module.ec2-instance_example_volume-attachment.ec2_id
# }

