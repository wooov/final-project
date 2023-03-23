
# EC2
resource "aws_eip" "bastion" {
 instance = aws_instance.bastion.id
 vpc = true
}

resource "aws_instance" "bastion" {
  ami = "${var.bastion_ami}"
  instance_type = "${var.bastion_instance_type}"
  vpc_security_group_ids = [aws_security_group.bastion_ec2_sg]
  subnet_id = aws_subnet.NAT-pub.id
  key_name = "${var.bastion_key_name}"
  disable_api_termination = true
  root_block_device {
    volume_size =  "${var.bastion_volume_size}"
    volume_type = "gp3"
    delete_on_termination = true
  }
}