data "archive_file" "landing_dist" {
  type        = "zip"
  source_dir  = "${path.module}/../landing/dist"
  output_path = "${path.module}/landing.zip"
}

resource "null_resource" "netlify_deploy" {
  triggers = {
    zip_hash = data.archive_file.landing_dist.output_sha256
  }

  provisioner "local-exec" {
    command = "curl -X POST -H \"Authorization: Bearer ${var.netlify_auth_token}\" -H \"Content-Type: application/zip\" --data-binary \"@${data.archive_file.landing_dist.output_path}\" https://api.netlify.com/api/v1/sites/${var.netlify_site_name}/deploys"
  }
}

