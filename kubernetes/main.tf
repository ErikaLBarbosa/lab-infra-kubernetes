resource "null_resource" "lab_eb_1" {

   triggers = {
     token         = var.token,
   }

  connection {
    type        = "ssh"
    host        = var.master_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "3m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo CRIANDO DIR KUBEFILES",
      "mkdir -p /home/ec2-user/kubefiles",
      "echo VERIFICANDO SE O KUBEFILES FOI CRIADO",
      "ls -la /home/ec2-user",
    ]

  }

  provisioner "file" {
    destination = "/home/ec2-user/kubefiles/kubeadm-init-config.yaml"
    content = templatefile(
      "${path.module}/templates/kubeadm-init-config.yaml",
      {
        master_ip     = var.master_ip,
        master_ip_pri = var.master_ip_pri,
        token         = var.token,
        kubernetes_v  = var.kubernetes_v,
        kluster_name  = var.kluster_name,
      }
    )
  }

  provisioner "remote-exec" {
    inline = [
      "echo MOVENDO ARQUIVO DE TMP PARA KUBEFILES",
      "echo VERIFICANDO SE OS ARQUIVOS FORAM MOVIDOS",
      "cd /home/ec2-user/kubefiles",
      "ls -la /home/ec2-user/kubefiles",
      "echo USANDO KUBEFILES",
      "sudo kubeadm init --config /home/ec2-user/kubefiles/kubeadm-init-config.yaml",
      "echo CRIANDO CONFIG PARA EC2-USER",
      "sudo mkdir -p /home/ec2-user/.kube",
      "sudo cp -f /etc/kubernetes/admin.conf /home/ec2-user/.kube/config",
      "sudo chown -R $USER: /home/ec2-user/.kube",
      "echo GERANDO CA_CERT_HASH",
      "sudo openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* /sha256:/' > /home/ec2-user/.kube/ca_cert_hash",
      "kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml",
    ]

  }

}

data "remote_file" "kube_config" {
  depends_on = [
    null_resource.lab_eb_1
  ]
  conn {
    host        = var.master_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  path = "/home/ec2-user/.kube/config"
}

resource "local_file" "kubeconfig" {
  depends_on = [
    data.remote_file.kube_config
  ]
  content  = data.remote_file.kube_config.content
  filename = "${path.module}/templates/${yamldecode(data.remote_file.kube_config.content)["current-context"]}-config"
}

data "remote_file" "ca_cert_hash" {
  depends_on = [
    null_resource.lab_eb_1
  ]
  conn {
    host        = var.master_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  path = "/home/ec2-user/.kube/ca_cert_hash"
}

resource "null_resource" "lab_eb_2" {

   triggers = {
     master_ip     = var.master_ip,
     master_ip_pri = var.master_ip_pri,
     token_worker  = var.token,
     ca_cert_hash = data.remote_file.ca_cert_hash.content
   }

  connection {
    type        = "ssh"
    host        = var.worker_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "3m"
  }
  
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ec2-user/kubefiles"
    ]
  
  }

  provisioner "file" {
    destination = "/home/ec2-user/kubefiles/kubeadm-join-config.yaml"
    content = templatefile(
      "${path.module}/templates/kubeadm-join-config.yaml",
      {
        master_ip     = var.master_ip,
        master_ip_pri = var.master_ip_pri,
        token_worker  = var.token,
        ca_cert_hash = data.remote_file.ca_cert_hash.content
      }
    )
  }

  provisioner "remote-exec" {
    inline = [
      "cat /home/ec2-user/kubefiles/kubeadm-join-config.yaml",
      "sudo kubeadm join --config /home/ec2-user/kubefiles/kubeadm-join-config.yaml",      
    ]

  }

}