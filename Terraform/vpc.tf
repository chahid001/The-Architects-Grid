resource "aws_vpc" "vpc01" {
  
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "vpc-01"
  }
}

resource "aws_vpc" "vpc02" {

    cidr_block = "172.28.0.0/16"

    tags = {
      Name = "vpc-02"
    }
}

# Subnet for VPC01 -> Bastion Host
resource "aws_subnet" "vpc01-subnet-pub" {

    vpc_id = aws_vpc.vpc01.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "vpc01-sub-pub"
    }
}

# Subnet for VPC02 -> Public for LoadBalancer / NAT
variable "vpc02-subnets-public" {

  description = "List of public subnets for VPC 2"
  type = map(object({
    cidr_block = string
    az = string
  }))

  default = {
    "vpc02-sub1-pub" = {
        cidr_block = "172.28.1.0/24"
        az = "us-east-1a"
    },

    "vpc02-sub2-pub" = {
        cidr_block = "172.28.2.0/24"
        az = "us-east-1b"
    },

    "vpc02-sub3-pub" = {
        cidr_block = "172.28.3.0/24"
        az = "us-east-1c"
    }
  }
}

resource "aws_subnet" "vpc02-subnet-pub" {

    for_each = var.vpc02-subnets-public

    vpc_id = aws_vpc.vpc02.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az

    tags = {
      Name = each.key
    }
}

# Subnet for VPC02 -> Private for App
variable "vpc02-subnets-private" {

    description = "List of private subnets for VPC 2"
    type = map(object({
      cidr_block = string
      az = string 
    }))

    default = {
        "vpc02-sub1-prv" = {
            cidr_block = "172.28.4.0/24"
            az = "us-east-1a"
        },

        "vpc02-sub2-prv" = {
            cidr_block = "172.28.5.0/24"
            az = "us-east-1b"
        },
    }
}

resource "aws_subnet" "vpc02-subnet-prv" {

    for_each = var.vpc02-subnets-private

    vpc_id = aws_vpc.vpc02.id
    cidr_block = each.value.cidr_block
    availability_zone = each.value.az

    tags = {
      Name = each.key
    }
}