# terraform-aws-vpc-vs

Terraform module for creating a customizable AWS VPC with public and private subnets, Internet Gateway, NAT Gateway support, and route tables.

## Features

* Configurable VPC CIDR block
* Multiple public subnets
* Multiple private subnets
* Internet Gateway
* Optional NAT Gateway(s)
* Public and private route tables
* DNS hostname and DNS support configuration
* Custom tagging support

## Usage

```hcl
module "vpc" {
  source = "github.com/victorsand0val/terraform-aws-vpc-vs"

  vpc_name = "example-vpc"
  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway = true
  single_nat_gateway = true
}
```

## Inputs

| Name                 | Description                |
| -------------------- | -------------------------- |
| vpc_name             | Name of the VPC            |
| vpc_cidr             | CIDR block for the VPC     |
| availability_zones   | List of availability zones |
| public_subnet_cidrs  | Public subnet CIDRs        |
| private_subnet_cidrs | Private subnet CIDRs       |
| enable_nat_gateway   | Enable NAT Gateway         |
| single_nat_gateway   | Use a single NAT Gateway   |
| enable_dns_hostnames | Enable DNS hostnames       |
| enable_dns_support   | Enable DNS support         |
| tags                 | Common tags                |

## Outputs

| Name                    |
| ----------------------- |
| vpc_id                  |
| vpc_cidr_block          |
| public_subnet_ids       |
| private_subnet_ids      |
| nat_gateway_ids         |
| internet_gateway_id     |
| public_route_table_ids  |
| private_route_table_ids |
