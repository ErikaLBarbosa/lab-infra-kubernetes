variable "region"{
    type = string
    default = "us-east-1"
}

variable "instance_name"{
    type = string
    default = "lab-eb"
}

variable "amis" {
    type = map
    // ami amazon linux t3small
    default = {
        "us-east-1" = "ami-0cff7528ff583bf9a"
        "us-east-2" = "ami-0aeb7c931a5a61206"
    }
}

variable "instance_type" {
    type = string
    default = "t3.small"
}

variable "key_name" {
    type = string
    default = "lab-eb"
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

variable "security_groups_ids" {
    default = ["default_sg_id","ingress_all_sg_id"]
  
}

variable "private_key_path" {
  type = string
}

variable "token" {
  type    = string
  default = "abgs5j.2yda49sp3iyv1u1e"
}

variable "kubectl_v" {
  default = "4.5.4"
}

variable "kubernetes_v" {
  default = "1.26.0"
}

variable "kluster_name" {
  default = "kubelab"
}

