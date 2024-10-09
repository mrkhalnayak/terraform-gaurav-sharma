terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
  }
}

### here we could have given the variable like this also "{var.github-token}" github-token is the variable so this are 2 types for using the variable in general ###

provider "github" {
  token = var.github-token
}
