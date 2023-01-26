provider "aws" {
    version = "~> 3.0"
    region  = "${var.region}"
    shared_credentials_file = "~/.aws/credentials"
    profile = "<profile de acesso a aws>"
}

//VPC

resource "aws_vpc" "vpc"{
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "${var.environment}-vpc"
        Environment = "${var.environment}"
    }
}

/*subnet 4 ssh*/

resource "aws_subnet" "subnet_ssh" {
  cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "us-east-1a"
}

/* gateway*/
resource "aws_internet_gateway" "lab_eb_gw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = {
        Name = "lab_eb_gw"
    }
  
}

/*route table for ssh access*/
resource "aws_route_table" "route_table_lab" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.lab_eb_gw.id}"
    }

    tags = {
      Name = "lab_eb_route_table"
    }
  
}

resource "aws_route_table_association" "subnet-association" {
    subnet_id = "${aws_subnet.subnet_ssh.id}"
    route_table_id = "${aws_route_table.route_table_lab.id}"
  
}

/*vpc security group*/
resource "aws_security_group" "default" {
    name = "${var.environment}-default-sg"
    description = "Security Group padrao para permitir inbound e outbound do VPC"
    vpc_id = "${aws_vpc.vpc.id}"
    depends_on = [aws_vpc.vpc]
    
    ingress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        self = true
    }

    egress {
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        self = "true"
    }
    tags = {
        Environment = "${var.environment}"
    }
  
}
/*vpc security group ssh access*/
resource "aws_security_group" "ingress-all" {
    name = "allow-all-sg"
    depends_on = [aws_vpc.vpc]
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 8080
        to_port = 8080
        protocol = "tcp"
    }
}
//kubernetes master rules
resource "aws_security_group" "master-rules" {
    name = "master-rules"
    depends_on = [aws_vpc.vpc]
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 6443
        to_port = 6443
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 2379
        to_port = 2379
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 2380
        to_port = 2380
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 10250
        to_port = 10250
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 10259
        to_port = 10259
        protocol = "tcp"
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 10257
        to_port = 10257
        protocol = "tcp"
    }         

}

// kubernetes worker rules
resource "aws_security_group" "worker-rules" {
    name = "worker-rules"
    depends_on = [aws_vpc.vpc]
    vpc_id = "${aws_vpc.vpc.id}"

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 10250
        to_port = 10250
        protocol = "tcp"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 30000
        to_port = 30000
        protocol = "tcp"
    }        

    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
    from_port = 32767
        to_port = 32767
        protocol = "tcp"
    }      

}


