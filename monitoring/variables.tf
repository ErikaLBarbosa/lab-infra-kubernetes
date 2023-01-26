variable "master_ip" {
  type        = string
  description = "Ip do node master"
}

variable "module_depends_on" {
  type    = any
  default = "module.aws"
}

variable "private_key_path" {
  type = string
}