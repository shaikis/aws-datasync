resource "aws_iam_instance_profile" "datasync-instance-profile"{
    name = var.aws_instance_profile_name
    role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.data_sync_agent_iam_role
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_instance" "datasync" {
  depends_on                           = [data.aws_subnet.subnets]

  ami                                  = data.aws_ami.datasync-agent.id
  instance_type                        = var.agent_instance_type
  instance_initiated_shutdown_behavior = "stop"

  disable_api_termination              = false
  iam_instance_profile                 = aws_iam_instance_profile.datasync-instance-profile.name
  key_name                             = var.ec2_key_pair

  vpc_security_group_ids               = aws_security_group.datasync_agent_sg.id
  subnet_id                            = data.aws_subnet.subnets.0.id
  associate_public_ip_address          = false

  tags = {
    Name = "datasync-agent-instance-prod"
  }
}