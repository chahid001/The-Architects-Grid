resource "aws_instance" "bastion-ec2" {

    ami = var.ami-bastion
    instance_type = "t2.micro"
    subnet_id = aws_subnet.vpc01-subnet-pub.id
    key_name = var.key-name

    vpc_security_group_ids = [ aws_security_group.bastion-sec.id ]

    tags = {
      Name = "Bastion-Host"
    }
}

resource "aws_eip" "bastion-eip" {
    instance = aws_instance.bastion-ec2.id

    tags = {
      Name = "bation-ip"
    }
}