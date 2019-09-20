# variables.tf

variable "region" {
 default = "us-east-1"
}

variable "availabilityZone" {
        default = "us-east-1a"
}

variable "instanceTenancy" {
 default = "default"
}

variable "dnsSupport" {
 default = true
}

variable "dnsHostNames" {
        default = true
}

variable "vpcCIDRblock" {
 default = "10.0.0.0/16"
}

variable "public_subnet_1_CIDRblock" {
        default = "10.0.1.0/24"
}

variable "public_subnet_2_CIDRblock" {
        default = "10.0.2.0/24"
}

variable "private_subnet_1_CIDRblock" {
        default = "10.0.3.0/24"
}

variable "private_subnet_2_CIDRblock" {
        default = "10.0.4.0/24"
}

variable "destinationCIDRblock" {
        default = "0.0.0.0/0"
}


variable "mapPublicIP" {
        default = true
}

variable "vpc_name" {
			description = "Name for VPC"
}

variable "public_subnet_1_name"{
			description = "Name for Public Subnet 1"
}

variable "public_subnet_2_name"{
			description = "Name for Public Subnet 2"
}

variable "private_subnet_1_name"{
			description = "Name for Private Subnet 1"
}

variable "private_subnet_2_name"{
			description = "Name for Private Subnet 2"
}

variable "sc_name"{
			description = "Security Group Name"

}