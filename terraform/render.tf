resource "render_web_service" "backend" {
  name   = "condocombat-backend"
  plan   = "free"
  region = "oregon"
  
  runtime_source = {
    image = {
      image_url = "docker.io/${var.dockerhub_username}/condocombat-backend:latest"
    }
  }

  env_vars = {
    "DATABASE_URL" = {
      value = "postgresql://postgres.${supabase_project.database.id}:${var.supabase_db_password}@aws-0-sa-east-1.pooler.supabase.com:6543/postgres"
    }
    "SECRET_KEY" = {
      value = var.backend_secret_key
    }
  }
}

resource "render_web_service" "frontend" {
  name   = "condocombat-frontend"
  plan   = "free"
  region = "oregon"

  runtime_source = {
    image = {
      image_url = "docker.io/${var.dockerhub_username}/condocombat-frontend:latest"
    }
  }

  env_vars = {
    "NEXT_PUBLIC_API_URL" = {
      value = render_web_service.backend.url
    }
  }
}

output "backend_url" {
  value = render_web_service.backend.url
}

output "frontend_url" {
  value = render_web_service.frontend.url
}
