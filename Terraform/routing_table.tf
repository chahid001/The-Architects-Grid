resource "aws_route_table" "vpc01-rt-pub" {

    vpc_id = aws_vpc.vpc01.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw1.id
    }

    tags = {
      Name = "route-table-public-vpc1"
    }
}

resource "aws_route_table_association" "rt-sub-vpc1" {
    route_table_id = aws_route_table.vpc01-rt-pub.id
    subnet_id = aws_subnet.vpc01-subnet-pub.id
}

resource "aws_route_table" "vpc02-rt-pub" {

    vpc_id = aws_vpc.vpc02.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw2.id
    }

    tags = {
      Name = "route-table-public-vpc2"
    }
}

resource "aws_route_table_association" "rt-sub-vpc2" {
    for_each = aws_subnet.vpc02-subnet-pub
    route_table_id = aws_route_table.vpc02-rt-pub.id
    subnet_id = each.value.id
}

resource "aws_route_table" "vpc02-rt-prv" {

    vpc_id = aws_vpc.vpc02.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.vpc-nat.id
    }

    tags = {
      Name = "route-table-private-vpc2"
    }
}

resource "aws_route_table_association" "rt-prv-vpc2" {
    for_each = aws_subnet.vpc02-subnet-prv
    route_table_id = aws_route_table.vpc02-rt-prv.id
    subnet_id = each.value.id
}