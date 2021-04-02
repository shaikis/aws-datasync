resource "aws_datasync_agent" "datasyncagent" {
  ip_address = aws_instance.datasync_agent.public_ip
  name       = var.data_sync_agent_name
}