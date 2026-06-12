run "full_deployment" {

  command = plan

  variables {
    vpc_name = "integration-vpc"

    vpc_cidr = "10.10.0.0/16"

    availability_zones = [
      "us-east-1a",
      "us-east-1b"
    ]

    public_subnet_cidrs = [
      "10.10.1.0/24",
      "10.10.2.0/24"
    ]

    private_subnet_cidrs = [
      "10.10.101.0/24",
      "10.10.102.0/24"
    ]

    enable_nat_gateway = true
    single_nat_gateway = true
  }

  assert {
    condition     = length(output.public_subnet_ids) == 2
    error_message = "Expected two public subnets."
  }

  assert {
    condition     = length(output.private_subnet_ids) == 2
    error_message = "Expected two private subnets."
  }

  assert {
    condition     = output.vpc_cidr_block == "10.10.0.0/16"
    error_message = "Unexpected VPC CIDR block."
  }
}

run "route_table_validation" {

  command = plan

  variables {
    vpc_name = "routing-test"

    vpc_cidr = "10.20.0.0/16"

    availability_zones = [
      "us-east-1a",
      "us-east-1b"
    ]

    public_subnet_cidrs = [
      "10.20.1.0/24",
      "10.20.2.0/24"
    ]

    private_subnet_cidrs = [
      "10.20.101.0/24",
      "10.20.102.0/24"
    ]

    enable_nat_gateway = true
    single_nat_gateway = true
  }

  assert {
    condition     = length(aws_route_table_association.public) == 2
    error_message = "Expected two public route table associations."
  }

  assert {
    condition     = length(aws_route_table_association.private) == 2
    error_message = "Expected two private route table associations."
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 1
    error_message = "Expected a single NAT Gateway."
  }
}