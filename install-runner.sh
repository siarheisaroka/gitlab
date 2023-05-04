#!/bin/bash

set -x

check_service_status() {
    local service_name="$1"

    # Check if the service is running
    systemctl is-active $1 >/dev/null 2>&1
    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "The $service_name service is running."
    else
        echo "The $service_name service is not running."
    fi

    return $exit_code
}

check_runner() {
    if which gitlab-runner ; then
    sudo gitlab-runner unregister --all-runners
    sudo -u gitlab-runner gitlab-runner unregister --all-runners
    fi
    install_runner

}

install_runner() {
    
    # Download the binary for your system
    sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

    # Give it permission to execute
    sudo chmod +x /usr/local/bin/gitlab-runner

    # Create a GitLab Runner user
    if id -u gitlab-runner >/dev/null 2>&1; then
        echo "User exists"
    else
        sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
        sudo rm -f /home/gitlab-runner/.bash_logout
    fi

    # Install and run as a service
    if test -f /etc/systemd/system/gitlab-runner.service; then
        echo "The service gitlab-runner installed."
    else
        sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    fi

    if test -f /etc/systemd/system/gitlab-runner.service; then
        sudo systemctl stop gitlab-runner
    fi
    gitlab-runner unregister --all-runners
    TYPE='shell'
    URL='https://gitlab.skillbox.ru/'
    REGISTRATION_TOKEN='GR1348941q2ktiuXp1tK-4c4W6Bg_'
    NAME=$(hostname)
    TAG="TAG1"
    sudo -u gitlab-runner gitlab-runner register \
        --non-interactive \
        --url=$URL \
        --registration-token=$REGISTRATION_TOKEN \
        --executor=$TYPE \
        --description=$NAME \
        --tag-list=$TAG
    sudo chmod o+r /home/gitlab-runner/.gitlab-runner/config.toml

    if [ -f /home/gitlab-runner/.gitlab-runner/config.toml ]; then
        echo "Copy config file to /etc/gitlab-runner/config.toml"
        sudo cp -f /home/gitlab-runner/.gitlab-runner/config.toml /etc/gitlab-runner/config.toml
    fi

    if test -d /etc/gitlab-runner; then
        sudo chown gitlab-runner:gitlab-runner /etc/gitlab-runner
    fi

    if test -f /etc/gitlab-runner; then
        sudo chown gitlab-runner:gitlab-runner /etc/gitlab-runner/config.toml
    fi

    if test -f /etc/gitlab-runner; then
        sudo chown gitlab-runner:gitlab-runner /etc/gitlab-runner/runner_system_id
    fi

    sudo systemctl start gitlab-runner
    sudo systemctl enable gitlab-runner
}

check_runner
