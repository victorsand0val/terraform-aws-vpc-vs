run "minimal_vpc" {

  command = plan

  variables {
    vpc_name = "test-vpc"

    vpc_cidr = "10.0.0.0/16"

    availability_zones = [
      "us-east-1a"
    ]

    public_subnet_cidrs = [
      "10.0.1.0/24"
    ]

    private_subnet_cidrs = [
      "10.0.101.0/24"
    ]

    enable_nat_gateway = false
  }

  assert {
    condition     = aws_vpc.this.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block does not match expected value."
  }

  assert {
    condition     = aws_vpc.this.enable_dns_hostnames == true
    error_message = "DNS hostnames should be enabled."
  }
}

run "multi_az_vpc" {

  command = plan

  variables {
    vpc_name = "multi-az"

    vpc_cidr = "10.1.0.0/16"

    availability_zones = [
      "us-east-1a",
      "us-east-1b"
    ]

    public_subnet_cidrs = [
      "10.1.1.0/24",
      "10.1.2.0/24"
    ]

    private_subnet_cidrs = [
      "10.1.101.0/24",
      "10.1.102.0/24"
    ]

    enable_nat_gateway = false
  }

  assert {
    condition     = length(aws_subnet.public) == 2
    error_message = "Expected 2 public subnets."
  }

  assert {
    condition     = length(aws_subnet.private) == 2
    error_message = "Expected 2 private subnets."
  }
}

run "single_nat_gateway" {

  command = plan

  variables {
    vpc_name = "nat-test"

    vpc_cidr = "10.2.0.0/16"

    availability_zones = [
      "us-east-1a",
      "us-east-1b"
    ]

    public_subnet_cidrs = [
      "10.2.1.0/24",
      "10.2.2.0/24"
    ]

    private_subnet_cidrs = [
      "10.2.101.0/24",
      "10.2.102.0/24"
    ]

    enable_nat_gateway = true
    single_nat_gateway = true
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 1
    error_message = "Expected exactly one NAT Gateway."
  }
}

run "multiple_nat_gateways" {

  command = plan

  variables {
    vpc_name = "multi-nat"

    vpc_cidr = "10.3.0.0/16"

    availability_zones = [
      "us-east-1a",
      "us-east-1b"
    ]

    public_subnet_cidrs = [
      "10.3.1.0/24",
      "10.3.2.0/24"
    ]

    private_subnet_cidrs = [
      "10.3.101.0/24",
      "10.3.102.0/24"
    ]

    enable_nat_gateway = true
    single_nat_gateway = false
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 2
    error_message = "Expected one NAT Gateway per public subnet."
  }
}

run "nat_disabled" {

  command = plan

  variables {
    vpc_name = "no-nat"

    vpc_cidr = "10.4.0.0/16"

    availability_zones = [
      "us-east-1a"
    ]

    public_subnet_cidrs = [
      "10.4.1.0/24"
    ]

    private_subnet_cidrs = [
      "10.4.101.0/24"
    ]

    enable_nat_gateway = false
  }

  assert {
    condition     = length(aws_nat_gateway.this) == 0
    error_message = "NAT Gateway should not exist."
  }
}