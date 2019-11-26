resource "aws_route53_record" "main" {
    count = length(var.dns_records)
    
    zone_id = lookup(element(var.dns_records, count.index), "zone_id", null)
    name    = lookup(element(var.dns_records, count.index), "name", null)
    type    = lookup(element(var.dns_records, count.index), "type", "A")
    ttl     = lookup(element(var.dns_records, count.index), "ttl", 3600)
    records = lookup(element(var.dns_records, count.index), "records", [ aws_instance.main.private_ip ])
}