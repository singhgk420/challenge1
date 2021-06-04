
resource "aws_launch_template" "template" {
  name_prefix   = "asg-template"
  image_id      = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "frontend-asg" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}
resource "aws_autoscaling_group" "backend-asg" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.template.id
    version = "$Latest"
  }
}