data "aws_route53_zone" "my_zone" {
  name         = "***"
  private_zone = false
}

resource "null_resource" "update_route53_record_webapp" {
  triggers = {
    alb_dns_name = var.webapp-lb-dns-name # Trigger update when ALB DNS name changes
  }

  provisioner "local-exec" {
    command = <<EOT
      aws route53 change-resource-record-sets \
        --hosted-zone-id ${data.aws_route53_zone.my_zone.zone_id} \
        --change-batch '{
          "Changes": [{
            "Action": "UPSERT",
            "ResourceRecordSet": {
              "Name": "***",
              "Type": "A",
              "AliasTarget": {
                "HostedZoneId": "${var.webapp-lb-zone-id}",
                "DNSName": "${var.webapp-lb-dns-name}",
                "EvaluateTargetHealth": true
              }
            }
          }]
        }'
    EOT
  }
}

resource "null_resource" "update_route53_record_backend" {
  triggers = {
    alb_dns_name = var.backend-lb-dns-name # Trigger update when ALB DNS name changes
  }

  provisioner "local-exec" {
    command = <<EOT
      aws route53 change-resource-record-sets \
        --hosted-zone-id ${data.aws_route53_zone.my_zone.zone_id} \
        --change-batch '{
          "Changes": [{
            "Action": "UPSERT",
            "ResourceRecordSet": {
              "Name": "api.***",
              "Type": "A",
              "AliasTarget": {
                "HostedZoneId": "${var.backend-lb-zone-id}",
                "DNSName": "${var.backend-lb-dns-name}",
                "EvaluateTargetHealth": true
              }
            }
          }]
        }'
    EOT
  }
}