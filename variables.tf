variable "pub_key" {
    type = string
}

variable "vpc_cidr" {
    type = string
}

variable "a_zones" {
    type = list(string)
}

variable "public_subnets" {
    type = list(string)
}

variable "private_subnets" {
    type = list(string)
}

variable "vpc_name" {
    type = string
}

variable "cluster_name" {
    type = string
}