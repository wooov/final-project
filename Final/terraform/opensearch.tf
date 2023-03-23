resource "aws_opensearch_domain" "opensearch" {
  domain_name    = "teamf-opensearch-domain"
  cluster_config {
    instance_type = "t2.small.search"
  }
  ebs_options {
    ebs_enabled = true
    volume_size = 10
  }
}


