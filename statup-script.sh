gsutil cp gs://techplace/install-runner.sh /root/
chmod +x /root/install-runner.sh
/root/install-runner.sh
systemctl status gitlab-runner
sudo apt update && sudo apt install git -y
gsutil cp gs://techplace/docker_inst.sh /root/
chmod +x /root/docker_inst.sh
/root/docker_inst.sh