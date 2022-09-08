resource "aws_s3_bucket" "this" {
  bucket = var.bucket
  tags = {
    Environment = "dev"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "public-read"
}

resource "aws_s3_object" "this" {
  for_each = toset(["index", "error"])
  bucket   = aws_s3_bucket.this.bucket
  key      = "${each.key}.html"
  source   = "${path.module}/web/${each.key}.html"
  etag     = filemd5("${path.module}/web/${each.key}.html")
}

# resource "aws_s3_bucket_website_configuration" "this" {
#   bucket = aws_s3_bucket.this.id

#   index_document {
#     suffix = "index.html"
#   }

#   error_document {
#     key = "error.html"
#   }

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.this.json
}
data "aws_iam_policy_document" "this" {
  statement {
    # principals {
    #   type        = "AWS"
    #   identifiers = ["123456789012"]
    # }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*",
    ]
  }
}