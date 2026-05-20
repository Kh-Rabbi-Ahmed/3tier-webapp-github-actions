resource "aws_instance" "database" {
    ami = "ami-05cf1e9f73fbad2e2"
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    key_name = var.key_pair_name
    tags = {
        Name = "database"
    }
}