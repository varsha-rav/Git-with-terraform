provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "allow_tls" {
    name = "allowtls"
    description = "Created and managed from terraform"
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


resource "aws_instance" "ec2" {
  ami = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_tls.id]

  
}