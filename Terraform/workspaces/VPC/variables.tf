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

variable "cert_body" {
  type = string
  description = "SSL Certificate Body"
}

variable "cert_private_key" {
  type = string
  description = "SSL Certificate PK"
}