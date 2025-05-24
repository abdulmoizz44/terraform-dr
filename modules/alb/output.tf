output "webapp-lb-dns-name" {
  value = aws_lb.company-webapp.dns_name
}

output "webapp-lb-zone-id" {
  value = aws_lb.company-webapp.zone_id
}

output "backend-lb-dns-name" {
  value = aws_lb.company-backend.dns_name
}

output "backend-lb-zone-id" {
  value = aws_lb.company-backend.zone_id
}

output "webapp-tg-arn" {
  value = aws_lb_target_group.webapp-tg.arn
}

output "backend-tg-arn" {
  value = aws_lb_target_group.backend-tg.arn
}