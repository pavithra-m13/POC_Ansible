resource "docker_image" "sonarqube" {
  name = "sonarqube:latest"
}
resource "docker_container" "sonarqube_server" {
  image = docker_image.sonarqube.image_id
  name  = "sonarqube-container"

  ports {
    internal = 9000
    external = 9000
  }

  restart = "always"

}