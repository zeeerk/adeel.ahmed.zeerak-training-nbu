variable "region" {
  default = "us-east-1"
}

provider "aws" {
  profile    = "692560313237_Allowed_IAM_N.Virgina_CodeCommit"
  region     = var.region
}

resource "aws_instance" "adeel-example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
	 tags = {
    Name        = "Adeel-Terraform-EC2-Name-Changed"
    Environment = "Dev"
  }
	
	provisioner "local-exec" {
    command = "echo ${aws_instance.adeel-example.public_ip} > ip_address.txt"
  }
	
	depends_on = [aws_s3_bucket.adeel-terraform-example]
}

resource "aws_eip" "ip" {
    vpc = true
    instance = aws_instance.adeel-example.id
}
 
resource "aws_s3_bucket" "adeel-terraform-example" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "adeel-terraform-getting-started-guide"
  acl    = "private"
}

output "ip" {
  value = aws_eip.ip.public_ip
}