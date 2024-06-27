terraform {
  cloud {
    organization = "online-octopus"

    workspaces {
      name = "backloggd-discord-dev"
    }
  }
}
