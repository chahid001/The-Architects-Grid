resource "aws_ec2_transit_gateway" "ts" {

    description = "Transit gateway for VPC's"
    amazon_side_asn = var.ANS

    tags = {
      Name = "ts-vpc"
    }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "ts-attach-vpc1" {

    transit_gateway_id = aws_ec2_transit_gateway.ts.id
    vpc_id = aws_vpc.vpc01.id
    subnet_ids = [aws_subnet.vpc01-subnet-pub.id]

    tags = {
      Name = "ts-attach-1"
    }

    depends_on = [ aws_subnet.vpc01-subnet-pub ]
  
}

resource "aws_ec2_transit_gateway_vpc_attachment" "ts-attach-vpc2" {


    transit_gateway_id = aws_ec2_transit_gateway.ts.id
    vpc_id = aws_vpc.vpc02.id
    subnet_ids = [
        aws_subnet.vpc02-subnet-prv["vpc02-sub1-prv"].id, 
        aws_subnet.vpc02-subnet-prv["vpc02-sub2-prv"].id
    ]

    tags = {
      Name = "ts-attach-2"
    }
  
    depends_on = [ aws_subnet.vpc02-subnet-prv ]
}