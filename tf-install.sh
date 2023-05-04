#!/bin/bash
inst_tf() {
    apt update && apt install wget -y
    if [ ! -e /usr/share/keyrings/hashicorp-archive-keyring.gpg ]; then
        echo "gpg not found"
        wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    fi
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
}

package_name="terraform"

# Check if package is installed
if dpkg -s $package_name >/dev/null 2>&1; then
    echo "$package_name is already installed"
else
    echo "Start install $package_name"
    inst_tf
fi
