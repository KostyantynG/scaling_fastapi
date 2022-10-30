# Create a launch template
resource "aws_launch_template" "scaling_fastapi_template" {
  name = "scaling-fastapi-launch-template-tf"
  image_id = "ami-0d593311db5abb72b"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  key_name = "vockey"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = filebase64("userdata.sh")
  iam_instance_profile {
    name = "LabInstanceProfile"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Scaling fastapi server"
    }
  }
}

# Create an Autoscaling Group
resource "aws_autoscaling_group" "scaling_fastapi_autoscaling_group" {
  vpc_zone_identifier = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.scaling_fastapi_template.id
    version = "$Latest"
  }
}

# Create autoscaling group attachment to a load balancer
resource "aws_autoscaling_attachment" "asg_attachment_webserver" {
  autoscaling_group_name = aws_autoscaling_group.scaling_fastapi_autoscaling_group.id
  lb_target_group_arn    = aws_lb_target_group.scaling_fastapi_target_group.arn
}