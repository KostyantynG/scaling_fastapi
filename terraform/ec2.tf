# Create EC2 instance
resource "aws_instance" "scaling_fastapi_server" {
  ami           = "ami-0d593311db5abb72b"
  instance_type = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_subnet_a.id
  vpc_security_group_ids      = [aws_security_group.allow_http_lb.id]
  key_name                    = "vockey"
  user_data                   = file("userdata.sh")

  tags = {
    Name = "Scaling Fastapi Server"
  }
}