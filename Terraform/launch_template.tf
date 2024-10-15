resource "aws_launch_template" "web-app" {
    name_prefix   = "web-app-"
    image_id      = var.golden-ami
    instance_type = "t2.micro"

    key_name = var.key-name
    vpc_security_group_ids = [ aws_security_group.app-sec.id ]
    
    
    user_data = filebase64("./../scripts/userdata.sh")

    iam_instance_profile {
      name = var.app-vm-role
    }

}
