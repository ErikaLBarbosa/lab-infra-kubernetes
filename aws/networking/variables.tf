variable "region"{
    type = string
    default = "us-east-1"
}

variable "environment"{
    default = "Deployment Environment"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "private_subnets_cidr" {
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24",]
  
}

variable "availability_zone" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "security_groups_ids" {
    default = ["default_sg_id","ingress_all_sg_id"]
  
}