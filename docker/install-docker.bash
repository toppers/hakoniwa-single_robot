#!/bin/bash

### Note: this script is based on:
### https://docs.docker.com/engine/install/ubuntu/

if service --status-all |& grep docker ;
then
    echo "WARNING: docker seems to be already installed."
    read -n1 -p "Do you want to continue the script? (y/N): " yn;
    if [[ $yn = [yY] ]]
    then
        :
    else 
        echo "aborted."
        exit 1
    fi
fi

# Set up the repository
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:
sudo rm -f /etc/apt/keyrings/docker.gpg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Use the following command to set up the stable repository. 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
