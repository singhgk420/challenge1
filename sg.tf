resource "aws_security_group" "internet_lb_sg" {
  name        = "security_group"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.Test-vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "http"
    cidr_blocks      = [aws_vpc.Test-vpc.cidr_block]
  }
}