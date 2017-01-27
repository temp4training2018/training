#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-butterfly
#

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable thing_count {
#  type    = "string"
  default = "1"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

output "public_dns" {
  value = ["${aws_instance.autodesk-butterfly.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.autodesk-butterfly.*.public_ip}"]
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "autodesk-butterfly" {
  ami                    = "ami-30217250"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-ddd57685"
  vpc_security_group_ids = ["sg-29ef374e"]
  count                  = "${var.thing_count}"

  tags {
    Identity     = "autodesk-butterfly"
    ADSK_service = "TRAINING-ADHOC-unknown"
    special      = "special"
    Name         = "autodesk-butterfly ${count.index + 1}/${var.thing_count}"
  }
}

/*
module "example" {
  source = "./example-module"
}
*/
