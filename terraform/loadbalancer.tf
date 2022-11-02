# Create Target group
resource "aws_lb_target_group" "scaling_fastapi_target_group" {
  name     = "scaling-fastapi-server-target"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.scaling_fastapi_vpc.id

  health_check {
    path = "/"
    port = 80
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 10
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

# Create Load Balancer
resource "aws_lb" "scaling_fastapi_lb" {
  name               = "scaling-fastapi-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_lb.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
}

# Add Target Group as a Listener to Load Balancer
resource "aws_lb_listener" "scaling_fastapi_listener" {
  load_balancer_arn = aws_lb.scaling_fastapi_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.scaling_fastapi_target_group.arn
  }
}

# Create Elastic IP
resource "aws_eip" "nat_ip" {
  vpc      = true
}

# Create NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet_a.id

  tags = {
    Name = "NAT IGW"
  }

  # To ensure proper ordering, add an explicit dependency on the IGW for the VPC.
  depends_on = [aws_internet_gateway.scaling_fastapi_igw]
}

# Create private Route Table
resource "aws_default_route_table" "private_route_table" {
  default_route_table_id = aws_vpc.scaling_fastapi_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }


  tags = {
    Name = "Private route table"
  }
}