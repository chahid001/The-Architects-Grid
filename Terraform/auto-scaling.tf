resource "aws_autoscaling_group" "as-app" {

    launch_template {
      name = aws_launch_template.web-app.name
      version = "$Latest"
    }

    min_size = 1
    max_size = 4
    vpc_zone_identifier = [ 
        aws_subnet.vpc02-subnet-prv["vpc02-sub1-prv"].id,
        aws_subnet.vpc02-subnet-prv["vpc02-sub2-prv"].id,
    ]
    target_group_arns = [ aws_lb_target_group.target-group.arn ]

    
}