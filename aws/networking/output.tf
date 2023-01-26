output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_id" {
    value = aws_subnet.subnet_ssh.id
}

output "default_sg_id" {
    value = aws_security_group.default.id
}

output "ingress_all_sg_id" {
    value = aws_security_group.ingress-all.id
}

output "master-rules" {
    value = aws_security_group.master-rules.id
}

output "worker-rules" {
    value = aws_security_group.worker-rules.id
}
