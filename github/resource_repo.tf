provider "github" {
    token = "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"
  
}

resource "github_repository" "Azure_terrafrom_repo" {
  name        = "Azure_terrafrom_repo"
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true

  template {
    owner                = "github"
    repository           = "terraform-template-module"
    include_all_branches = true
  }
}