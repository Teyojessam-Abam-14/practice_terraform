#Declaring security groups for Load Balancer
resource "aws_security_group" "public-sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "pub-sg-tf"
  description = "Public security group for Load Balancer"

  tags = {
    Name        = "pub-sg-tf"
    Environment = "Production"
    OwnerEmail  = "teyojessam.abam@gmail.com"
  }
}

#HTTP rule
resource "aws_security_group_rule" "http-vpc-pub" {
  security_group_id = aws_security_group.public-sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}


#Outbound rule
resource "aws_security_group_rule" "outbound-vpc-pub" {
  security_group_id = aws_security_group.public-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

###################################################################################################

#Declaring security groups for private Apache server
resource "aws_security_group" "web-sg" {
  vpc_id      = aws_vpc.my_vpc.id
  name        = "web-sg-tf"
  description = "Private security group for Apache server"

  tags = {
    Name        = "web-sg-tf"
    Environment = "Production"
    OwnerEmail  = "teyojessam.abam@gmail.com"
  }
}

#SSH rule (with source as my IP address)
resource "aws_security_group_rule" "ssh-web" {
  security_group_id        = aws_security_group.web-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
   cidr_blocks = ["${chomp(data.external.my_ip.result["output"])}/32"]
}

#HTTP rule (with source as the Public security group)
resource "aws_security_group_rule" "http-web" {
  security_group_id        = aws_security_group.web-sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.public-sg.id
}


#Outbound rule
resource "aws_security_group_rule" "outbound-web" {
  security_group_id = aws_security_group.web-sg.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}
