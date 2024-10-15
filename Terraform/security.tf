resource "aws_security_group" "bastion-sec" {

    vpc_id = aws_vpc.vpc01.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "bastion-security-group"
    }
}

resource "aws_security_group" "app-sec" {

    vpc_id = aws_vpc.vpc02.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" 
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "app-security-group"
    }
}

