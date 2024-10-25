variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

#List of availability zones 
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
}

#Name for Launch Template
variable "lt_name"{
  default = "apache-lt-terraform"
}

#AMI ID
variable "ami_id" {
  default = "ami-0ddc798b3f1a5117e"
}

#Fetching my Public IP address 
data "external" "my_ip" {
  program = ["bash", "-c", "echo '{\"output\": \"'$(curl -s https://checkip.amazonaws.com)'\"}'"]
}


#Name for Load Balancer
variable "lb_name"{
   default = "apache-lb-terraform"
}

#Name for Target Group
variable "tg_name"{
  default = "Apache-TG"
}

#Name for Autoscaling Group
variable "asg_name"{
  default = "Apache-asg-terraform"
}

#Launch Temp details
variable "LT_DETAILS" {
  type=map(string)
  default = {
    instance_type = "t2.micro"
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }
}

#Load balancer details for the load balancer resource
variable "LB_DETAILS" {
  type=map(string)
  default={
    internal=false
    load_balancer_type="application"
    enable_deletion_protection=false
    enable_cross_zone_load_balancing=true
  }
}

#Target group details for the target group resource
variable "TG_DETAILS" {
  type=map(string)
  default={
    port=80
    protocol="HTTP"
  }
}

#Health check details for the target group resource
variable "HEALTH_CHECK_DETAILS" {
  type=map(string)
  default={
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 3
  }
}

#Listener details for the listener resource
variable "LISTEN_DETAILS" {
  type=map(string)
  default={
    port=80
    protocol="HTTP"
    default_action_type="forward"
  }
}

#Autoscaling group details for the autoscaling group resource
variable "ASG_DETAILS" {
  type=map(string)
  default={
    launch_template_version="$Latest"
    min_size=1
    max_size=1
    health_check_grace_period=300
    health_check_type="EC2"
    desired_capacity=1
    propagate_at_launch=true
  }
}
#VPC details for VPC resource
variable "VPC_DETAILS" {
  type=map(string)
  default={
    cidr_block="10.0.0.0/16"
    enable_dns_hostnames=true
    instance_tenancy="default"
    name="terra_VPC-infra"
  }
}

#Subnet count for Public and Private servers
variable "SUBNET_COUNT" {
  type=map(string)
  default={
    public_count=2
    private_count=2
  }
}

#Internet and NAT Gateway details
variable "IG_NAT_DETAILS" {
  type=map(string)
  default={
    igw_name="igw-tf"
    nat_1a_name="nat_1a-tf"
    nat_1b_name="nat_1b-tf"
  }  
}

#Elastic IP details
variable "EIP_DETAILS"{
  type=map(string)
  default={
    domain="vpc"
    eip1_name="elastic_ip-tf_1"
    eip2_name="elastic_ip-tf_2"
  }
}

#Public route table details
variable "PUB_RT_DETAILS"{
  type=map(string)
  default={
    cidr_block="0.0.0.0/0"
    rt_assc_count=2
    name="public_route_table_tf"
  }
}

#Private route table details
variable "PRIV_RT_DETAILS"{
  type=map(string)
  default={
    cidr_block1="0.0.0.0/0"
    cidr_block2="0.0.0.0/1"
    rt_assc_count=2
    name="private_route_table_tf"
  }
}


#CIDRs for Public Subnets
variable "public_subnet_cidr" {
  type    = list(any)
  default = ["10.0.4.0/23", "10.0.22.0/23"]
}

#CIDRs for Private Subnets
variable "private_subnet_cidr" {
  type    = list(any)
  default = ["10.0.12.0/22", "10.0.8.0/22"]
}

#List of availability zones 
variable "subnet_azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

#List of public subnet names
variable "public_subnet_names" {
  type    = list(any)
  default = ["public_subnet_1a", "public_subnet_1b"]
}

#List of private subnet names
variable "private_subnet_names" {
  type = list(any)
  default = ["private_subnet_1a", "private_subnet_1b"]
}






