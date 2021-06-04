# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA5YFVRHIDIVY3Z24X"
  secret_key = ""
}
#creation of vpc
resource "aws_vpc" "Test-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support ="true"

  tags = {
    Name = "Demo-vpc"
  }
}
##creation of internet gateway
resource "aws_internet_gateway" "Test-IG" {
  vpc_id = aws_vpc.Test-vpc.id

  tags = {
    Name = "Demo-IG"
  }
}
##creating 2 public subnet in vpc
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.Test-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Demo-public-subnet-1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.Test-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Demo-public-subnet-2"
  }
}
##creating two private subnets in vpc
resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.Test-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Demo-private-subnet1"
  }
}
resource "aws_subnet" "subnet4" {
  vpc_id     = aws_vpc.Test-vpc.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Demo-private-subnet-2"
  }
}
##creation of two route table one for public subnet and other for private subnet
resource "aws_route_table" "Routetable1" {
  vpc_id = aws_vpc.Test-vpc.id

 # route {
  # cidr_block = "10.0.1.0/16"
   # gateway_id = aws_internet_gateway.Test-IG.id
  #}

 #route {
  # ipv6_cidr_block        = "::/0"
  #egress_only_gateway_id = aws_egress_only_internet_gateway.T.id
  #}

  tags = {
    Name = "Demo-public-RT"
  }
}
resource "aws_route_table" "Routetable2" {
  vpc_id = aws_vpc.Test-vpc.id

 #route {
 # cidr_block = "10.0.1.0/24"
  #gateway_id = aws_internet_gateway..id
  #}

  #route {
   # ipv6_cidr_block        = "::/0"
   #egress_only_gateway_id = aws_nat_gateway.gw.id
#}

  tags = {
    Name = "Demo-private-RT"
  }
}
##Associating route table to different subnet
resource "aws_route_table_association" "Demo1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.Routetable1.id
}
resource "aws_route_table_association" "Demo2" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.Routetable2.id
}

##creating NAT gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "gw NAT"
  }
}
resource "aws_eip" "lb" {
  vpc      = true
}

