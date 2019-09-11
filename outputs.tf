output "instance" {
    value = aws_instance.main
}
output "security_group" {
    value = aws_security_group.main
}
output "dns_record" {
    value = aws_route53_record.main
}