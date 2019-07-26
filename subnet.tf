resource "aws_subnet" "ui" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "api" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "db" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "10.0.3.0/24"
}

