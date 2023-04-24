resource "github_repository" "terraform_first_repo" {
  name        = "first_Demo_repo_from_terraform"
  description = "My awesome Terraform codebase"
  auto_init   = true
  visibility  = "public"
}

resource "github_repository" "terraform_second_repo" {
  name        = "Second_Demo_repo_from_terraform"
  description = "My awesome Terraform codebase"
  auto_init   = true
  visibility  = "public"
}