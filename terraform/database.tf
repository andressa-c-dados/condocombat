resource "supabase_project" "database" {
  organization_id   = var.supabase_organization_id
  name              = "condocombat-db"
  database_password = var.supabase_db_password
  region            = "sa-east-1"
}

output "supabase_db_url" {
  value = "postgresql://postgres.${supabase_project.database.id}:${var.supabase_db_password}@aws-0-sa-east-1.pooler.supabase.com:6543/postgres"
  sensitive = true
}

