#!/bin/bash

# add alias
alias ll="ls -al"
alias tf="terraform"

# install gitlab runner
gsutil cp gs://techplace/install-runner.sh /root/
chmod +x /root/install-runner.sh
sed -i 's:TAG="TAG1":TAG="GCP":g' /root/install-runner.sh
/root/install-runner.sh
systemctl status gitlab-runner

# install git
sudo apt update && sudo apt install git -y

# install docker
gsutil cp gs://techplace/docker_inst.sh /root/
chmod +x /root/docker_inst.sh
/root/docker_inst.sh

# install terraform
gsutil cp gs://techplace/tf-install.sh /root/
chmod +x /root/tf-install.sh
/root/tf-install.sh
