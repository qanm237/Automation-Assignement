/*
  Private EC2 in private subnet 1
*/

resource "aws_security_group" "ec2-priv-sg" {
    name = "vpc_priv_ec2"
    description = "ec2 launched in private subnet"

      
    ingress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["${var.public_subnet_cidr}"]

    }

   
    egress { 
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr2}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "EC2-priv-sg"
    }
}

resource "aws_instance" "ec2-priv" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1b"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.ec2-priv-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1b-private1.id}"
    associate_public_ip_address = true
    source_dest_check = false 
    depends_on=["aws_db_instance.rds-priv2"]
 
    provisioner "file" {
    source      = "sql_preq.sh"
    destination = "/tmp/sql_preq.sh"
  }
    provisioner "file" {
    source      = "terraform.tfstate"
    destination = "/tmp/terraform.tfstate"
  }
    provisioner "file" {
    source      = "sql_crud.py"
    destination = "/tmp/sql_crud.py"
  }


    provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/sql_preq.sh",
      "/tmp/script.sh args",
    ]
  }


    tags {
        Name = "EC2 private"
    }
}

