# VPC with 2 public and 2 private subnets and a security Group

provider "aws" {
  profile    = "281668362239_Allowed_IAM_N.Virgina_CodeCommit"
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
	ingress {
    cidr_blocks = "${var.ingressCIDRblock}"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
	protocol = -1
	from_port = 0 
	to_port = 0 
	cidr_blocks = ["0.0.0.0/0"]
	}
}


#  ------------------------------------------------->>>>>>>Create the Internet Gateway
resource "aws_internet_gateway" "Adeel_GW_VPC" {
  vpc_id = "${aws_vpc.Adeel-Terraform-VPC.id}"
  tags = {
        Name = "Adeel VPC Internet Gateway"
    }
}
 

# ------------------------------------------------->>>>>>> Bastion Host in public subnet
resource "aws_instance" "Adeel-Public-Subnet-EC2" {
  ami =  "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
  subnet_id =  "${aws_subnet.Adeel_Public_Subnet_1.id}"
	associate_public_ip_address = "true"
  key_name = "adeek-key"
  vpc_security_group_ids = ["${aws_security_group.Adeel_TerraForm_VPC_Security_Group.id}"]
  tags = {
    Name = "Adeel-Bastion-Host"
  }
}

# ---------------------------------------->>>> EC2 instance in private subnet
resource "aws_instance" "Adeel-Private-Subnet-EC2" {
  ami           = "ami-0b69ea66ff7391e80"
  instance_type = "t2.micro"
	key_name = "adeek-key"
  subnet_id = "${aws_subnet.Adeel_Private_Subnet_1.id}"
	security_groups = ["${aws_security_group.Adeel_Security_Group_Private.id}"]
  tags = {
    Name = "Adeel-Private-Subnet-EC2"
  }
}

# ---------------------------------->>>>>>>>>> Create the Route Table
resource "aws_route_table" "Adeel_route_table" {
    vpc_id = "${aws_vpc.Adeel-Terraform-VPC.id}"
  tags = {
        Name = "Adeel VPC Route Table"
    }
}


# ---------------------------------------->>>>Create the Internet Access
resource "aws_route" "Adeel_VPC_internet_access" {
  route_table_id        = "${aws_route_table.Adeel_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.Adeel_GW_VPC.id}"
} # end resource

# ---------------------------------------->>>>Associate the Route Table with the Subnet
resource "aws_route_table_association" "Adeel_VPC_association" {
    subnet_id      = "${aws_subnet.Adeel_Public_Subnet_1.id}"
    route_table_id = "${aws_route_table.Adeel_route_table.id}"
}


resource "aws_security_group" "Adeel_Security_Group_Private" {
  vpc_id       = "${aws_vpc.Adeel-Terraform-VPC.id}"
  name         = "Adeel Security Group Private"
  description  = "Adeel Security Group Private"

ingress {
    cidr_blocks = ["10.0.1.0/24"]  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

tags = {
        Name = "Adeel Private Instance Security Group"
  }
}