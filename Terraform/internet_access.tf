resource "aws_internet_gateway" "igw1" {

    vpc_id = aws_vpc.vpc01.id
    tags = {
      Name = "vpc01-igw"
    }

    depends_on = [ aws_vpc.vpc01 ]
}

resource "aws_internet_gateway" "igw2" {

    vpc_id = aws_vpc.vpc02.id
    tags = {
      Name = "vpc02-igw"
    }

    depends_on = [ aws_vpc.vpc02 ]
}

resource "aws_eip" "nat-ip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "vpc-nat" {
    allocation_id = aws_eip.nat-ip.id
    subnet_id = aws_subnet.vpc02-subnet-pub["vpc02-sub3-pub"].id

    tags = {
        Name = "vpc-nat"
    }

    depends_on = [ aws_subnet.vpc02-subnet-pub ]
}