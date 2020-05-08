resource "aws_route53_record" "main_private" {
  count = length(var.dns_records_internal_hosted_zone) > 0 ? length(var.dns_records_internal_hosted_zone) : 0

  zone_id = lookup(element(var.dns_records_internal_hosted_zone, count.index), "zone_id", null)
  name    = lookup(element(var.dns_records_internal_hosted_zone, count.index), "name", null)
  type    = lookup(element(var.dns_records_internal_hosted_zone, count.index), "type", "A")
  ttl     = lookup(element(var.dns_records_internal_hosted_zone, count.index), "ttl", 3600)
  records = lookup(element(var.dns_records_internal_hosted_zone, count.index), "records", [aws_instance.main.private_ip])
}

resource "aws_route53_record" "main_public" {
  count = length(var.dns_records_public_hosted_zone) > 0 && var.associate_public_ip_address == true ? length(var.dns_records_public_hosted_zone) : 0

  zone_id = lookup(element(var.dns_records_public_hosted_zone, count.index), "zone_id", null)
  name    = lookup(element(var.dns_records_public_hosted_zone, count.index), "name", null)
  type    = lookup(element(var.dns_records_public_hosted_zone, count.index), "type", "A")
  ttl     = lookup(element(var.dns_records_public_hosted_zone, count.index), "ttl", 3600)
  records = lookup(element(var.dns_records_public_hosted_zone, count.index), "records", [aws_eip.this.*.public_ip[count.index]])
}