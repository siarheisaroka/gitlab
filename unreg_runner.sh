#!/bin/bash
sudo gitlab-runner unregister --all-runners
sudo -u gitlab-runner gitlab-runner unregister --all-runners
