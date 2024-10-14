resource "aws_route_table" "vpc01-rt-pub" {

    vpc_id = aws_vpc.vpc01.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw1.id
    }

    route {
        cidr_block = "172.28.0.0/16"
        gateway_id = aws_ec2_transit_gateway.ts.id
    }

    tags = {
      Name = "route-table-public-vpc1"
    }

    depends_on = [ aws_ec2_transit_gateway.ts, aws_ec2_transit_gateway_vpc_attachment.ts-attach-vpc1 ]
}

resource "aws_route_table_association" "rt-sub-vpc1" {
    route_table_id = aws_route_table.vpc01-rt-pub.id
    subnet_id = aws_subnet.vpc01-subnet-pub.id
}

resource "aws_route_table" "vpc02-rt-pub" {

    vpc_id = aws_vpc.vpc02.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw2.id
    }

    route {
        cidr_block = "192.168.0.0/16"
        gateway_id = aws_ec2_transit_gateway.ts.id
    }

    tags = {
      Name = "route-table-public-vpc2"
    }

    depends_on = [ aws_ec2_transit_gateway.ts, aws_ec2_transit_gateway_vpc_attachment.ts-attach-vpc2]
}

resource "aws_route_table_association" "rt-sub-vpc2" {
    for_each = aws_subnet.vpc02-subnet-pub
    route_table_id = aws_route_table.vpc02-rt-pub.id
    subnet_id = each.value.id
}

resource "aws_route_table" "vpc02-rt-prv" {

    vpc_id = aws_vpc.vpc02.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.vpc-nat.id
    }

    route {
        cidr_block = "192.168.0.0/16"
        gateway_id = aws_ec2_transit_gateway.ts.id
    }

    tags = {
      Name = "route-table-private-vpc2"
    }
    depends_on = [ aws_ec2_transit_gateway.ts, aws_ec2_transit_gateway_vpc_attachment.ts-attach-vpc2 ]
}

resource "aws_route_table_association" "rt-prv-vpc2" {
    for_each = aws_subnet.vpc02-subnet-prv
    route_table_id = aws_route_table.vpc02-rt-prv.id
    subnet_id = each.value.id
}