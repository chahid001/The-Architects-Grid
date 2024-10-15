resource "aws_lb_target_group" "target-group" {

    name = "web-app-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc02.id
}

resource "aws_lb" "web-app-lb" {

    name = "web-app-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.app-sec.id ]
    subnets = [ 
        aws_subnet.vpc02-subnet-pub["vpc02-sub1-pub"].id,
        aws_subnet.vpc02-subnet-pub["vpc02-sub2-pub"].id,
    ]
}

resource "aws_lb_listener" "web-app-listener" {
  load_balancer_arn = aws_lb.web-app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}