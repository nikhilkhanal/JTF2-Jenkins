# Specify the provider and version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region                  = "us-east-1"  # Specify your desired AWS region
  shared_credentials_file = "C:\\Users\\Anubhav\\.aws\\credentials"  # Path to AWS credentials file
}

# Define a key pair for SSH access
resource "aws_key_pair" "my_key" {
  key_name   = "my-terraform-key"
  public_key = file("D:\\myterraformkey.pub")  # Path to your public key file
}

# Launch an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-005fc0f236362e99f"  # Example AMI ID for Amazon Linux 2 in us-west-2
  instance_type = "t3.micro"  # Choose the instance type
  associate_public_ip_address = true

  # Add the key pair for SSH access
  key_name = aws_key_pair.my_key.key_name

  # Tag the instance for identification
  tags = {
    Name = "JTF2TerraformInstance"
  }
  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }
}
