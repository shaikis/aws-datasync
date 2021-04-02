resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = data.aws_vpc.vpc_id
  service_name      = var.data_sync_service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.endpoint_sg.id,
  ]

  private_dns_enabled = true
}