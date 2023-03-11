#!/bin/bash

#Ensure there are no existing docker installs to prevent complications with new install

sudo apt-get remove docker docker-engine docker.io containerd runc

#Update packages and install dependencies.

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#Create Keyrings and pull down gpg keys.

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#Adding the repositories for future updates

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#Update to ensure repositories are current

sudo apt-get update

#Install All Docker packages and dependencies

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

#Run test docker container to ensure the install was successful

sudo docker run hello-world
