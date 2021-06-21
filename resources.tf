resource "aws_security_group" "nginxsecurity" {
  name = "nginxsecurity1"
  ingress {
  from_port        = 22
  to_port          = 22
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
  from_port        = 80
  to_port          = 80
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "myec2" {
  ami = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  key_name = "keypair"
  security_groups = [aws_security_group.nginxsecurity.name]


provisioner "remote-exec" {
      inline = [
        "sudo yum update -y",
        "sudo yum install httpd -y"
          ]
        }
provisioner "remote-exec" {
     when = destroy
        inline = [
            "sudo yum remove httpd -y"
          ]
        }
connection {
       type     = "ssh"
       user     = "ec2-user"
       private_key = file("./keypair.pem")
       host     = self.public_ip
     }

 tags = {
      Name = "server1"
    }
}

output  "aws_public_ip"{
  value = aws_instance.myec2.public_ip
}
