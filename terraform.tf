terraform {
  cloud {
    organization = "lunarops"

    workspaces {
      name = "homelab"
    }
  }
}
