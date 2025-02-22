terraform {
    required_providers {
        github = {
            source = "integrations/github"
            version = "~> 6.0"
        }
    }
}

# Configure the GitHub Provider
provider "github" {
    token = var.github_token
    owner = var.github_user
}

# Create repository
resource "github_repository" "TemplateRepo" {
  name        = "TemplateRepo"
  description = "New repository created"
  visibility  = "public"

  template {
    owner                = var.github_user
    repository           = "template"
    include_all_branches = true
  }
}

# Create branches
resource "github_branch" "development" {
    repository = github_repository.TemplateRepo.name
    branch = "development"
    source_branch = "main"
}

resource "github_branch" "test" {
    repository = github_repository.TemplateRepo.name
    branch = "test"
    source_branch = "main"
}

resource "github_branch" "fixes" {
    repository = github_repository.TemplateRepo.name
    branch = "fixes"
    source_branch = "main"
}