resource "aws_security_group" "bastion-sec" {

    vpc_id = aws_vpc.vpc01.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    
    tags = {
      Name = "bastion-security-group"
    }
}