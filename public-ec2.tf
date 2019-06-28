/*
  Public EC2
*/

resource "aws_security_group" "ec2-pub-sg" {
    name = "vpc_pub_ec2"
    description = "ec2 launched in public subnet"

      
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

   
    egress { 
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr1}"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "EC2-sg"
    }
}

resource "aws_instance" "ec2-pub" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["${aws_security_group.ec2-pub-sg.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "EC2 public"
    }
}


