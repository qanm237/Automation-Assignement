/*
RDS in private subnet2
*/
resource "aws_security_group" "rds-priv-sg" {
    name = "vpc_priv_rds"
    description = "rds launched in private subnet2"


    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr1}"]
    }


    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "RDS-sg"
    }
}


resource "aws_db_subnet_group" "rds-subnet" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  = ["${aws_subnet.us-east-1c-private2.id}","${aws_subnet.us-east-1b-private3.id}"]
}



resource "aws_db_instance" "rds-priv2" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    name                 = "akash"
    password             = "12345678"
    parameter_group_name = "default.mysql5.7"
    db_subnet_group_name = "${aws_db_subnet_group.rds-subnet.id}"
    availability_zone = "us-east-1c"
    vpc_security_group_ids = ["${aws_security_group.rds-priv-sg.id}"]
  
   
   tags {
        Name = "RDS private2"
    }
}

output "rds_endpoint" {
  value = "${aws_db_instance.rds-priv2.endpoint}"
}

output "name" {
  value = "${aws_db_instance.rds-priv2.name}"
}

output "password" {
  value = "${aws_db_instance.rds-priv2.password}"
}

