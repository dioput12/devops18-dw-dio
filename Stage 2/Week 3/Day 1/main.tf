terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "wayshub-frontend" {
  name         = "dioput12/wayshub-frontend:latest"
  keep_locally = false
}

resource "docker_container" "wayshub-frontend" {
  image = docker_image.wayshub-frontend.image_id
  name  = "wayshub-frontend"

  ports {
    internal = 3000
    external = 3000
  }
}
