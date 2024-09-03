

provider "aws" {
  region = "ap-south-1"
}

variable "BuildAMI" {
  description = "Build Server AMI"
  default     = "ami-0522ab6e1ddcc7055"
}

variable "BuildType" {
  description = "Build Server Type"
  default     = "t2.micro"
}

variable "BuildKey" {
  description = "Build Server Key"
  default     = "devops"
}

variable "BuildUser" {
  description = "Build User"
  default     = "ubuntu"
}

variable "SecurityGroupID" {
  description = "The ID of the security group to associate with the instance"
  default     = "sg-0a4b86efefd9999b7"
}


resource "aws_instance" "example" {
  ami                    = var.BuildAMI
  instance_type          = var.BuildType
  key_name               = var.BuildKey
  vpc_security_group_ids = [var.SecurityGroupID]  


# Add a tag for easier identification
  tags = {
    Name = "ExampleNode"
  }


  provisioner "local-exec" {
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; sleep 120; ansible-playbook buildsetup.yml -i ${aws_instance.example.private_ip}, -u ${var.BuildUser} --private-key /etc/ansible/${var.BuildKey}.pem"
  }
}
