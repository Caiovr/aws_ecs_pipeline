resource "aws_security_group" "cloudwatch_logs_endpoint_sg" {
  name_prefix = "cloudwatch-logs-endpoint-sg"
  vpc_id      = "vpc-0ff9103ecad7a0ba4"
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloudwatch_logs_endpoint_sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cloudwatch_logs_endpoint_sg.id
}
