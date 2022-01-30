resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "12.5"
  instance_class         = "db.t2.micro"
  identifier             = "kanduladb"
  username               = "postgres"
  password               = random_password.password.result
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_postgres.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name

}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = element(var.private_public_ids, 2)
}

resource "aws_security_group" "rds_postgres" {
  name        = "rds_sg"
  description = "Security group for Postgres RDS"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    iterator = port
    for_each = var.rds_ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%^&*()"
  min_special      = 1
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1

}
