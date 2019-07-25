resource "aws_key_pair" "default" {
  key_name = "new-key-pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
