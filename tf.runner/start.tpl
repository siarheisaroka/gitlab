#!/bin/bash

# add alias
alias ll="ls -al"
alias tf="terraform"

# install gitlab runner
gsutil cp gs://${ mybucket }/install-runner.sh /root/
sed -i 's:TAG="TAG1":TAG="GCP":g' /root/install-runner.sh
chmod +x /root/install-runner.sh
/root/install-runner.sh
systemctl status gitlab-runner

# install git
sudo apt update && sudo apt install git -y

# install docker
gsutil cp gs://${ mybucket }/docker_inst.sh /root/
chmod +x /root/docker_inst.sh
/root/docker_inst.sh

# install terraform
gsutil cp gs://${ mybucket }/tf-install.sh /root/
chmod +x /root/tf-install.sh
/root/tf-install.sh

#shutdown script
gsutil cp gs://${ mybucket }/unreg_runner.sh /root/
chmod +x /root/unreg_runner.sh
gsutil cp gs://${ mybucket }/run-before-shutdown.service /etc/systemd/system/
systemctl enable run-before-shutdown.service