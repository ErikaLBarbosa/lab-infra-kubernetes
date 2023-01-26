variable "master_ip" {
  type        = string
  description = "Ip do node master"
}

variable "master_ip_pri" {
  type        = string
  description = "Ip do node master"
}

variable "worker_ip" {
  type        = string
  description = "Ip do node master"
}

variable "worker_ip_pri" {
  type        = string
  description = "Ip do node master"
}

variable "token" {
  type    = string
  default = "<inserir token>" #gerar token através do comando kubeadm token generate
}

variable "k8s_context" {
  type        = string
  description = "kubernetes config context to be used"
  default     = "default"
}

variable "users_to_create" {
  type        = list(string)
  description = "List of users to exist in cluster"
  default     = []
}

variable "namespaces" {
  type        = list(string)
  description = "List of namespaces to grant access in cluster"
  default     = []
}

variable "k8s_cluster_endpoint" {
  type        = string
  description = "Kubernetes cluster endpoint"
  # default = 
}

variable "k8s_cluster_name" {
  type        = string
  description = "Kubernetes cluster name"
  default     = "kubelab"
}

variable "module_depends_on" {
  type    = any
  default = "module.aws"
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

variable "private_key_path" {
  type = string
}
