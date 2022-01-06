variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "cidr_size" {
  type        = string
  description = "CIDR Size"
}

variable "availability_zones" {
  type        = number
  description = "Availability zones to account for"
}
