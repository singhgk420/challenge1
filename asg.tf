
resource "aws_launch_template" "Demo-template" {
  name_prefix   = "Demo-template"
  image_id      = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
}


resource "aws_autoscaling_group" "Test-asg" {
  name = "Demo-asg"
  max_size = 2
  min_size = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  desired_capacity = 2
  force_delete = true
  vpc_zone_identifier = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

  launch_template {
    id = aws_launch_template.Demo-template.id
    version = "$Latest"
  }
}