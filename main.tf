module "aws" {
  source           = "./aws"
  private_key_path = "${path.root}/private_key/<sua-private-key.pem>" #endereço onde encontra-se sua private key
  # var.user = "ec2-user"
}

module "kubernetes" {
  source               = "./kubernetes"
  master_ip            = module.aws.master_ip
  master_ip_pri        = module.aws.master_ip_pri
  worker_ip            = module.aws.worker_ip
  worker_ip_pri        = module.aws.worker_ip_pri
  k8s_cluster_endpoint = module.aws.master_ip
  module_depends_on    = [module.aws]
  private_key_path     = "${path.root}/private_key/<sua-private-key.pem>" #endereço onde encontra-se sua private key
  # var.user = "ec2-user"
}

module "monitoring" {
  source            = "./monitoring"
  master_ip         = module.aws.master_ip
  private_key_path     = "${path.root}/private_key/<sua-private-key.pem>" #endereço onde encontra-se sua private key
  module_depends_on = [module.aws, module.kubernetes]
}