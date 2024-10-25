data "template_file" "server_bootstrap" {
  template = file(format("%s/server_btstrap.tpl", path.module))
}

#Outputs the load balancer domain name
output "load_balancer_dns_name" {
  value = aws_lb.apache-lb.dns_name
}

#Waits for the server to be created and healthy
resource "null_resource" "wait_for_server" {

  # Depends on the ASG to be created first
  depends_on = [aws_autoscaling_group.terraform_asg]

  provisioner "local-exec" {
    command = "sleep 60"  # Waiting for a minute
  }
}

#Retrieves data from a running server
data "aws_instances" "instances" {

  # Ensures that the we can get the data after the server creates
  depends_on = [null_resource.wait_for_server]

  filter {
    name   = "tag:Name"
    values = ["Apache-server-TF"]
  }
}

#Outputs the Public IP address of the running server
output "public_ip" {
  value = data.aws_instances.instances.private_ips
}