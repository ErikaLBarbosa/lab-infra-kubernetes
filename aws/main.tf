terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

//Criação da Instancia 1
resource "aws_instance" "lab_eb_1" {
  depends_on = [
    module.networking
  ]

  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  tags = {

    #inserir suas tags

  }
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = ["${module.networking.default_sg_id}", "${module.networking.ingress_all_sg_id}", "${module.networking.master-rules}"]
  subnet_id                   = module.networking.subnet_id
  associate_public_ip_address = true
  
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "3m"
  }

  provisioner "file" {
    source = "${path.module}/arquivos_config"
    destination = "/tmp"
  }

  provisioner "file" {
    source = "${path.module}/scripts/script_update.sh"
    destination = "/tmp/script_update.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ATUALIZANDO PERMISSÃO ARQUIVO SH",
      "chmod +x /tmp/script_update.sh",
      "DANDO RUN NO ARQUIVO SH",
      "/tmp/script_update.sh args",
    ]

  }

}

//Criação da Instancia 2
resource "aws_instance" "lab_eb_2" {
  depends_on = [
    module.networking
  ]

  ami           = var.amis["us-east-1"]
  instance_type = var.instance_type
  tags = {
      #inserir suas tags

  }
  key_name                    = var.key_name
  monitoring                  = true
  vpc_security_group_ids      = ["${module.networking.default_sg_id}", "${module.networking.ingress_all_sg_id}", "${module.networking.worker-rules}"]
  subnet_id                   = module.networking.subnet_id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "3m"
  }

  provisioner "file" {
    source = "${path.module}/arquivos_config"
    destination = "/tmp"
  }

  provisioner "file" {
    source = "${path.module}/scripts/script_update.sh"
    destination = "/tmp/script_update.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ATUALIZANDO PERMISSÃO ARQUIVO SH - INSTANCIA 2",
      "chmod +x /tmp/script_update.sh",
      "DANDO RUN NO ARQUIVO SH",
      "/tmp/script_update.sh args",
    ]

  }
 }

//Criando elastic IP
resource "aws_eip" "ip-vpc1" {
  depends_on = [
    resource.aws_instance.lab_eb_1
  ]
  instance = aws_instance.lab_eb_1.id
  vpc      = true
}

resource "aws_eip" "ip-vpc2" {
  depends_on = [
    resource.aws_instance.lab_eb_2
  ]
  instance = aws_instance.lab_eb_2.id
  vpc      = true
}

/*Provedor AWS*/
provider "aws" {
  version                 = "~> 3.0"
  region                  = var.region
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "<profile de acesso a aws>"
}

