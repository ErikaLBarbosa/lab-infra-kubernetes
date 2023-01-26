output "vpc_id" {
    value = "${module.networking.vpc_id}"
}

output "subnet_id" {
    value = ["${module.networking.subnet_id}"]
}

output "default_sg_id" {
    value = "${module.networking.default_sg_id}"
}

output "ingress_all_sg_id" {
    value = "${module.networking.ingress_all_sg_id}"
}


output "master_ip" {
    value = aws_instance.lab_eb_1.public_ip
}

output "master_ip_pri" {
    value = aws_instance.lab_eb_1.private_ip
}

output "worker_ip" {
    value = aws_instance.lab_eb_2.public_ip
}

output "worker_ip_pri" {
    value = aws_instance.lab_eb_2.private_ip
}
