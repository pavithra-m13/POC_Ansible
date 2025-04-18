resource "docker_image" "ansible"{
  name = "cytopia/ansible:latest"
}

resource "docker_container" "ansible_server" {
  image = docker_image.ansible.image_id
  name  = "ansible-container"
  command = ["sh", "-c", "apk update && apk add --no-cache py3-pip && pip3 install --upgrade ansible-core && sleep infinity"]
  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  volumes {
    host_path      = "/home/pavithra/project1/ansible"
    container_path = "/ansible"
  }
}
