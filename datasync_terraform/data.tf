data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet" "subnets" {
  count  = length(var.subnet_ids)

  vpc_id = data.aws_vpc.vpc.id
  id     = var.subnet_ids[count.index]
}


data "aws_ami" "datasync-agent" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aws-datasync-*"]
  }

  owners = [var.aws_account_owner] # AMZN
}
