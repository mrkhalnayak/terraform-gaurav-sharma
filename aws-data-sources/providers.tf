
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

### Data Source-> Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

## resource and it's type for data source we find from terraform documentation. 
data "aws_ami" "ubuntu" {        # resource type = "aws_ami" and it's name for terraform name = "ubuntu"
  most_recent = "true"           # "most_recent", and "owners" are arguments which we use update the values, this owner information we can find inside the ami search section in aws. 
  owners      = ["099720109477"] # we'll get owner id by searching the ami id inside the AMIs section in dashboard >> select public image >> update ami id >> serach it.
  # This will give's all the information about that particular ami id.


  filter { # This is also an argument which ask for many value for choosing the image like Name of the image which we can get from AMI's seach section.
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"] # we used "*" here because we want that after this {ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server} any version can be ok.
  }

  filter {
    name   = "root-device-type" # "root-device-type" is aksing for the type root volume which has 2 types "EBS/instance-store".
    values = ["ebs"]            # root-volume is "EBS".
  }

  filter {
    name   = "virtualization-type" # "virtualization-type" Image virtualization has 2 types "praavirtual/hvm".
    values = ["hvm"]               # Image "virtualization-type" is "hvm" here.
  }

}

output "ami-id" {
  value = data.aws_ami.ubuntu.id # From this we want to get the image for this ubuntu image. {resource.resource-type.resource-name.}
}