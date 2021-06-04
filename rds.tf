resource "aws_db_instance" "Rds_instance" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "Gauravsingh"
  password             = "***************"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
resource "aws_db_subnet_group" "Rds_subnet" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]

  tags = {
    Name = "My DB subnet group"
  }
}
