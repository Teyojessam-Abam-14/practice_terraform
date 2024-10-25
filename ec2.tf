#Declaring Launch template for Apache server
resource "aws_launch_template" "terraform_lt" {
  name                   = var.lt_name
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  user_data              = base64encode(data.template_file.server_bootstrap.rendered)
  image_id               = var.ami_id
  instance_type          = var.LT_DETAILS["instance_type"]
}