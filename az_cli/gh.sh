#!/bin/bash

# Variables
REPO=ACR-Corporation/runner_00
ACCESS_TOKEN=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

# Installation de jq
sudo apt-get install jq -y

# Recuperation du token d'enregistrement du runner
REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)


cd /home/pierrc && mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz

RUN chown -R pierrc ~pierrc && /home/pierrc/actions-runner/bin/installdependencies.sh

./config.sh --unattended --url https://github.com/${REPO} --token ${REG_TOKEN} --labels test-self-runner
./run.sh

