resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts-jdk17"
}

resource "docker_container" "jenkins_server" {
  image = docker_image.jenkins.image_id
  name  = "jenkins-container"
  user  = "root"

  ports {
    internal = 8080
    external = 9091
  }

  # Mount Jenkins home directory
  volumes {
    host_path      = "/var/jenkins_home"
    container_path = "/var/jenkins_home"
  }

  # Mount Docker socket to allow Jenkins to use host's Docker
  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  # Mount Docker binary so Jenkins can use `docker` command
  volumes {
    host_path      = "/usr/bin/docker"
        container_path = "/usr/bin/docker"
  }

  # Mount custom init scripts
  volumes {
    host_path      = abspath("${path.module}/init.groovy.d/disable_wizard.groovy")
    container_path = "/var/jenkins_home/init.groovy.d/disable_wizard.groovy"
  }

  volumes {
    host_path      = abspath("${path.module}/init.groovy.d/basic_security.groovy")
    container_path = "/var/jenkins_home/init.groovy.d/basic_security.groovy"
  }

  privileged = true
  restart    = "always"
}