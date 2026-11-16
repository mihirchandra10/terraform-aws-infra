output "alb_dns_name" {
  description = "Public URL of the web tier"
  value       = "http://${aws_lb.web.dns_name}"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
