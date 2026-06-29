resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

  tags = {
    Name = "test"
  }
}
  
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.test.id #call the vpc id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public subnet for test VPC"
  }

  
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.test.id #call the vpc id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "private subnet for test VPC"
  }

  
}

resource "aws_internet_gateway" "ig_vpc" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "IG_Test_VPC"
  }
  
}

#create pub;ic route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_vpc.id
    
  }
  
}

#create the private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "private RT for Test VPC"
  }

  
}

#Associate the public subnet to public RT
resource "aws_route_table_association" "pub_association" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
  
}

#Associate private subnet to private RT
resource "aws_route_table_association" "priv_association" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
  
}
