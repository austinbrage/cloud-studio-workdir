resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_vpc"
    Project = var.project_name
    Environment = var.environment
  })
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_subnet"
    Project = var.project_name
    Environment = var.environment
  })
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = concat(
      var.allow_ssh ? [{ from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }] : [],
      var.allow_http ? [{ from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }] : [],
      var.security_group_ingress
    )
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = concat(
      var.allow_all_egress ? [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }] : [],
      var.security_group_egress
    )
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_sg"
    Project = var.project_name
    Environment = var.environment
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_igw"
    Project = var.project_name
    Environment = var.environment
  })
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.main.id
  }

  tags = merge(var.common_tags, var.tags, {
    Name = "${var.project_name}_${var.environment}_rt"
    Project = var.project_name
    Environment = var.environment
  })
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_key_pair" "main" {
  count       = var.create_key_pair ? 1 : 0
  key_name    = var.key_name
  public_key  = var.create_key_pair ? file(var.public_key_path) : null
}
