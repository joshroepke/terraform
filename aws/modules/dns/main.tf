data "aws_route53_zone" "this" {
  name         = local.domain
  private_zone = false
}

resource "aws_route53_record" "web" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "dev.${local.domain}"
  type    = "A"

  alias {
    name                   = aws_s3_bucket.this.website_domain
    zone_id                = aws_s3_bucket.this.hosted_zone_id
    evaluate_target_health = true
  }
}