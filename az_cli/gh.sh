#!/bin/bash

# Variables
REPO=ACR-Corporation/runner_00
ACCESS_TOKEN=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

# Installation de jq
sudo apt-get install jq -y

# Recuperation du token d'enregistrement du runner
REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)


mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

./config.sh --unattended --url https://github.com/${REPO} --token ${REG_TOKEN} --labels test-self-runner
./run.sh

