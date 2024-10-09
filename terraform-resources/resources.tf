
resource "github_repository" "sample-1" {
  name        = "terraform-github-repo"
  description = "This is the depo for the github through the terraform"
  visibility  = "private"
  auto_init   = true
}

### For always when ever you are looking to get the output for any specific resources then we need to always use the <resource-type>.<resource-name>.<what the ourput you are looking from the resources>

output "terraform_repo_url" {
  value = github_repository.sample-1.ssh_clone_url
}