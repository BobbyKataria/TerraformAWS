resource "aws_instance" "frontend" {
  # ubuntu 18.04
  count = "1"
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  associate_public_ip_address = true
  key_name = "new-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "git clone https://github.com/BobbyKataria/AWS_MEAN_DOCKER.git",
      "cd AWS_MEAN_DOCKER",
      "./install.sh",
      "docker pull bobbykataria/ui",
      "docker run -d -p 80:80 bobbykataria/ui"
    ]
  }
}
resource "aws_instance" "api" {
  # ubuntu 18.04
  count = "1"
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  associate_public_ip_address = true
  key_name = "new-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "git clone https://github.com/BobbyKataria/AWS_MEAN_DOCKER.git",
      "cd AWS_MEAN_DOCKER",
      "./install.sh",
      "cd api",
      "docker build -t api:latest"
      "docker run -d -e -p 8080:8080 MONGO_HOST=${aws_instance.default3.private_ip} api:latest" 
    ]
  }
}
resource "aws_instance" "mongo" {
  # ubuntu 18.04
  count = "1"
  ami = "ami-0c30afcb7ab02233d"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.default.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  associate_public_ip_address = true
  key_name = "new-key-pair"
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = "${self.public_ip}"
      user = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "git clone https://github.com/BobbyKataria/AWS_MEAN_DOCKER.git",
      "cd AWS_MEAN_DOCKER",
      "./install.sh",
      "docker pull mongo:latest",
      "docker run -d -p 27017:27017 mongo:latest"
    ]
  }
}

