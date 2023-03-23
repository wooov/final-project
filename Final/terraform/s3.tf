resource "aws_s3_bucket" "teamf-fe" {
  bucket = "api.kimdoliving.com"
  acl    = "public-read"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "Production"
  }
}

resource "aws_s3_bucket_policy" "s3_example_bucket_policy" {
  bucket = aws_s3_bucket.teamf-fe.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*", 
      "Action": [ 
        "s3:GetObject",
        "s3:GetObjectVersion"
      ],
      "Resource": "${aws_s3_bucket.teamf-fe.arn}/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.teamf-fe.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

  routing_rule {
    condition {
        key_prefix_equals = "docs"
    }
    redirect {
       replace_key_prefix_with = "documents/"
    }
  }
}

output "bucket_id" {
  value = aws_s3_bucket.teamf-fe.id
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.website.website_domain
}