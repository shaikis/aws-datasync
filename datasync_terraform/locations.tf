#source location.
resource "aws_datasync_location_nfs" "example" {
  server_hostname = "nfs.example.com"
  subdirectory    = "/exported/path"

  on_prem_config {
    agent_arns = [aws_datasync_agent.example.arn]
  }
}

#Destination locaiton.
resource "aws_datasync_location_s3" "example" {
  s3_bucket_arn = aws_s3_bucket.example.arn
  subdirectory  = "/example/prefix"

  s3_config {
    bucket_access_role_arn = aws_iam_role.example.arn
  }
}

# smb location.
resource "aws_datasync_location_smb" "example" {
  server_hostname = "smb.example.com"
  subdirectory    = "/exported/path"

  user     = "Guest"
  password = "ANotGreatPassword"

  agent_arns = [aws_datasync_agent.example.arn]
}