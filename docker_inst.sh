#!/bin/bash
set -x
install_docker() {
  sudo apt-get remove docker docker-engine docker.io containerd runc
  sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
  sudo apt install docker-compose -y
  sudo sleep 10
  sudo systemctl restart docker
  sudo systemctl enable docker
  sudo docker run hello-world
}

check_service_status() {
  local service_name="$1"

  # Check if the service is running
  systemctl is-active "$service_name" >/dev/null 2>&1
  local exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo "The $service_name service is running."
  else
    echo "The $service_name service is not running."
  fi

  return $exit_code
}

if [ ! -e /lib/systemd/system/docker.service ]; then
  echo "Start Docker installation"
  install_docker
fi

if check_service_status "docker"; then
  echo "Docker installed"
else
  
  echo "Starting Docker"
  sleep 5
  systemctl restart docker
  systemclt enable docker
fi

# Adding gitlab-runner user to docker group
if id -u gitlab-runner >/dev/null 2>&1; then
  echo "Adding gitlab-runner user to docker group"
  sudo usermod -aG docker gitlab-runner
fi
