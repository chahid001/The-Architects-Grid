variable "ANS" {
  
  default = 64512
}

variable "ami-bastion" {

    default = "ami-0fff1b9a61dec8a5f"
  
}

variable "key-name" {

    default = "scalabale-vpc"
  
}

variable "golden-ami" {

    default = "ami-0ffd58b8dbfe542a6"
  
}

variable "app-vm-role" {
   
   default = "cloud-watch-role-ec2"

}