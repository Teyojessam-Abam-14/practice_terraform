Overview:
This README provides guidance on setting up and running Terraform scripts to create an AWS infrastructure environment. The setup includes a VPC with subnets, security groups, a load balancer, and an EC2 instance configured with Apache for web hosting. Below are the details of the required resources, setup commands, assumptions made, and how to verify the setup.

Resources:
-VPC: A dedicated network for the infrastructure.
-Subnets: Two public and two private subnets.
-Internet Gateway: Provides outbound internet access for resources in public subnets.
-NAT Gateways: Allows instances in private subnets to access the internet for software updates and other outbound connections.
-Elastic IPs: Static IPs assigned to the NAT Gateways.
-Route Tables: Separate public and private route tables to control traffic routing for the subnets.

-Public Security Group: Allows inbound HTTP traffic for web access.
-Private Security Group: Restricts inbound traffic to HTTP requests from the public security group and SSH access limited to a specific IP address (depending on who runs the code). 

-Bootstrap Script: Initializes and configures Apache on the EC2 instance to serve web requests.

-Variables: Stores variables for dynamic configuration of the resources.

-Launch Template: Configures the EC2 instance with specified settings and the Apache bootstrap script.
-Application Load Balancer : Distributes incoming traffic to the EC2 instance.
-Target Group and Listener: Direct traffic to the EC2 instance based on defined rules.
-Auto Scaling Group: Manages the EC2 instances, ensuring availability based on demand.

Output Values
-Load balancer DNS: The DNS name of the load balancer, used for accessing the web server.
-EC2 Instance IP Address: Provides direct access to the instance.

A provider file with the credentials and role assumptions required for AWS programmatic access, configured to use an IAM role named "Engineer."

Commands to run the setup:
-terraform init
-terraform validate
-terraform plan
-terraform apply 

Once satisfied with the results, the "terraform destroy" command was run to destroy the infrastructure

Assumptions Made:
-A VPC with both public and private subnets is needed. To enable internet access for resources, an Internet Gateway is added to public subnets and NAT Gateways to private subnets. Elastic IPs are assigned to the NAT Gateways to provide stable outbound internet access, and separate route tables control inbound and outbound traffic within each subnet.
-To enable high availability and scalability, an Application Load Balancer is configured to route traffic to the EC2 instances. An Auto Scaling Group is assumed necessary to dynamically manage the instance.
-A null_resource block is used to ensure the Auto Scaling Group has time to launch the EC2 instance before attempting to retrieve the instance's IP. The aws_instances data block then depends on this null_resource to ensure it waits until the instance is ready.


Verification Steps
-After the Terraform setup is complete, use the DNS name of the created load balancer.
-Enter the load balancer DNS URL in a web browser.
-If successful, the Apache test page should appear, confirming that the server is active and accessible through the load balancer.