provider "aws" {
  region = "us-east-1"
  access_key = "AKIATAN253FDZA52YNKH"
  secret_key = "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"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"

  tags = {
    Name = "Gaurav ec2"
  }
}
