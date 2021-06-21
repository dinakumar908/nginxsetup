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
       private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEA2a7e5MMbeMlJBML46KGVORunK785wBWlPf1X+0i0GUcKiyYK
mn14fkVw6Z36MUtw49ZawffGAQUSW37lTDHiddvszZVoenMOxoLvfbU/srwqLj4l
DOIMFVavT3/VuLkLwOYWnRiEOkTXEHINymIzbj5Gts9xhQhMG9uJ89RaayUfHs34
daGl0c5gEHOBxr4PmgBoBRNBwwwBz7plYFkMnPgF0Q0eBZhqkLkWFrUR2uzCY8ap
mMqiNVRqFPDiNtUM6/8JaQjzQe6vWE6JwynHE2GGPUNo78gsirB1OeLtNWmyNFNU
k+zv7GhiS/Dp67LD0j+uiqI+otcI8uCzwUt8OQIDAQABAoIBAQC0hm9W6+9GdjdV
+ZOO6SHloGc8wnNUNx84j3d9b0fchqvZxgyZHmDk5xXCyD6KzvOqH0RZA/BzPA+D
TXM/g0c5Us/JlpR0qCKiwkd2yu8ufRnGC8eSLYyzzZXJqkxFy0BSEv7B/Wj7Icfx
XYTOSC46yO7AAL02BDGKEMERMxRhMXom3l04usTBK0lhE/kmSt/LVTTo8hcuF4Ir
02haZn1Zoov9L1B+16a89rqePp08V94savQiLIE3ebV7OTCvMPpqeUnxJdysZeK/
RahIiJLx6OjCyn1c+dEENu6LenoG0ykJMfZdQusSzUOF15FUAuzGXvEZyR+UMTeC
dQ7+2X15AoGBAPORdJdRBNvV1GGaAdaaoJZuHXHNhe0FPfhig1YuMjz1BSuDDWpU
Xx4UtoQx/h+hkFxoOBziMmIgRQ+BS20kQEI1YP5nw6Lt5EPcqkI6KG9Sh6AHEUAQ
vwIyJAkcE4DwKaPyq+6bLYvehD32ocC9X2/vXPt+ksOcUnbMY3XyqsFrAoGBAOTL
MRjpVtXatBKyLpWxSDkJRW6s3CHcYVonQtCxOqlCAFXMW7ZzpE6tLYAwF09ln08n
1kFdCCFQtKsWtaHzHlwyDfcPU7MZpnkjG07+yOXnvUbgRpnrOGPZFydAT/xb8qYT
BwvD7kGAYEElJZoTyXcrSGefr9aHfTcHM4njDI3rAoGBAK30VoazkHrJTvOeIG36
5XJKlrDujhXnxoidIxvrxmmOvPCEmpI0S/KZ7Hihk9NXeljk/h5y1nUKgwg92XbL
izE+GlXYGftFV9+3u8ms67AGC2MZaRKOYzzYPrBa4vsVi0fSS0UQgwkAFQaEHKYh
GgZBt/DOR1d5T9QUyXw1ogqdAoGBAIlNr59FmUkpwNtfdzl6dN9VwwdSUaE4gmv6
F8zqL0wYQd87juaFq9tTbnT5Z2PMlriILbp4PELSDjqGnGYeYt/tYhgcaJyZDiCw
gtj7alEeq6Z3PadtVCAHzi9OFzJZc9tam+XhpYBFrH4r7s7yhPsxTHhzirDyCqEV
f0aGragVAoGAB2H2GZyGdjuT7MlOn2b3ay0ZoaCIXgAwbU2UqzegiP2Th/hJicDy
pcVdUgNAPQbH+sL7u1ei0Xxj71HjCDkUMENalTmy2eB26omx/4v/ChpA7hgb3nx2
f3Wur6LjmoH2oS05Hs7z4DhJrvDjr8z0kjDof5bsQoXMVWkXgOQuOx8=
-----END RSA PRIVATE KEY-----"
       host     = self.public_ip
     }

 tags = {
      Name = "server1"
    }
}

output  "aws_public_ip"{
  value = aws_instance.myec2.public_ip
}
