resource "null_resource" "lab_eb_1" {
     triggers = {
     worker_ip     = var.master_ip,
   }

  connection {
    type        = "ssh"
    host        = var.master_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "3m"
  }

  provisioner "file" {
    source = "${path.module}/scripts/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ATUALIZANDO PERMISSÃO ARQUIVO SH",
      "chmod +x /tmp/script.sh",
      "DANDO RUN NO ARQUIVO SH",
      "/tmp/script.sh args",
    ]
  
  }

}