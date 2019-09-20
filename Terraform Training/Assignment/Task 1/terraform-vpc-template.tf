# VPC with 2 public and 2 private subnets and a security Group

provider "aws" {
  profile    = "692560313237_Allowed_IAM_N.Virgina_CodeCommit"
  region     = "${var.region}"
}
 

# ----------------------------------------------->>>>>>>Create the VPC

resource "aws_vpc" "Adeel-Terraform-VPC"  {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames = "${var.dnsHostNames}"
	tags = {
    Name = "${var.vpc_name}"
  }
}



#  ----------------------------------------------->>>>>>>Create the Public Subnet number 1

resource "aws_subnet" "Adeel_Public_Subnet_1" {
  vpc_id                  = "${aws_vpc.Adeel-Terraform-VPC.id}"
  cidr_block              = "${var.public_subnet_1_CIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "${var.public_subnet_1_name}"
  }
}


#  ----------------------------------------------->>>>>>>Create the Public Subnet number 2

resource "aws_subnet" "Adeel_Public_Subnet_2" {
  vpc_id                  = "${aws_vpc.Adeel-Terraform-VPC.id}"
  cidr_block              = "${var.public_subnet_2_CIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "${var.public_subnet_2_name}"
  }
}


#  ----------------------------------------------->>>>>>>Create the Private Subnet number 1

resource "aws_subnet" "Adeel_Private_Subnet_1" {
  vpc_id                  = "${aws_vpc.Adeel-Terraform-VPC.id}"
  cidr_block              = "${var.private_subnet_1_CIDRblock}"
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "${var.private_subnet_1_name}"
  }
}



#  ----------------------------------------------->>>>>>>Create the Private Subnet number 2

resource "aws_subnet" "Adeel_Private_Subnet_2" {
  vpc_id                  = "${aws_vpc.Adeel-Terraform-VPC.id}"
  cidr_block              = "${var.private_subnet_2_CIDRblock}" 
  availability_zone       = "${var.availabilityZone}"
tags = {
   Name = "${var.private_subnet_2_name}"
  }
}


 
#  ----------------------------------------------->>>>>>>Create the Security Group

resource "aws_security_group" "Adeel_TerraForm_VPC_Security_Group" {
  vpc_id       = "${aws_vpc.Adeel-Terraform-VPC.id}"
  name         = "My VPC Security Group"
  description  = "My VPC Security Group"
tags = {
        Name = "${var.sc_name}"
  }
} 
