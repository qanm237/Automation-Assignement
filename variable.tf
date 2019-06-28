variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-1 = "ami-024a64a6685d05041" # Ubuntu 18.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr1" {
    description = "CIDR for the Private Subnet1"
    default = "10.0.2.0/24"
}

variable "private_subnet_cidr2" {
    description = "CIDR for the Private Subnet2"
    default = "10.0.3.0/24"
}

variable "private_subnet_cidr3" {
    description = "CIDR for the Private Subnet2"
    default = "10.0.4.0/24"
}


