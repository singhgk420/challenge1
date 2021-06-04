resource "aws_lb" "Test-lb1" {
  name               = "internet-facing"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  enable_deletion_protection = false
  security_groups = [aws_security_group.internet_lb_sg.id]


}
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Test-lb1.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}
resource "aws_lb" "Test-lb2" {
  name               = "internal"
  internal           = true
  load_balancer_type = "application"
  subnets            =[aws_subnet.subnet3.id, aws_subnet.subnet4.id]
  enable_deletion_protection = false

}
resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.Test-lb2.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }
}
resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Test-vpc.id
}
resource "aws_autoscaling_attachment" "asg_attachment1" {
  autoscaling_group_name = aws_autoscaling_group.frontend-asg.id
  alb_target_group_arn   = aws_lb_target_group.frontend_tg.arn
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Test-vpc.id
}
resource "aws_autoscaling_attachment" "asg_attachment2" {
  autoscaling_group_name = aws_autoscaling_group.backend-asg.id
  alb_target_group_arn   = aws_lb_target_group.backend_tg.arn
}
