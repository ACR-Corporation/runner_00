#!/bin/bash
VERSION="2.311.0"

# Installation de jq
sudo apt-get install jq -y

# Download the latest runner package
cd /home/pierrc && mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-${VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-${VERSION}.tar.gz


sudo chown -R pierrc ~pierrc