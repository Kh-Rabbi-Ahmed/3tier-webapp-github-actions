resource "aws_instance" "bastion" {
    ami = "ami-05cf1e9f73fbad2e2"
    instance_type = "t2.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    key_name = var.key_pair_name
    user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo apt-get install -y uidmap
    sudo usermod -aG docker ubuntu
    sudo chmod 666 /var/run/docker.sock
    dockerd-rootless-setuptool.sh install --force
    sudo docker login -u agkanon -p agkanon@143

   

    echo "Bastion host ready" >> /var/log/bootstrap.log
    EOF
    
    tags = {
        Name = "bastion"
    }
}