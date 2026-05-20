resource "aws_security_group" "bastion_sg"{
    name = "bastion_sg"
    vpc_id = var.vpc_id

    ingress {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTPS access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "backend_sg"{
    name = "backend_sg"
    vpc_id = var.vpc_id

    ingress {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }
    ingress {
        description = "app access"
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "database_sg"{
    name = "database_sg"
    vpc_id = var.vpc_id

    ingress {
        description = "ssh access"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
    }

    ingress {
        description = "postgress port"
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = [aws_security_group.backend_sg.id]
    }    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}