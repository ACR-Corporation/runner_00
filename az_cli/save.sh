#!/bin/bash
REPO="ACR-Corporation/runner_00"
ACCESS_TOKEN="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"
VERSION="2.311.0"


# Installation de jq
sudo apt-get install jq -y

# Recuperation du token d'enregistrement du runner
REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /home/pierrc && mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-${VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz
tar xzf ./actions-runner-linux-x64-${VERSION}.tar.gz

sudo chown -R pierrc ~pierrc

./config.sh --unattended --url https://github.com/${REPO} --token ${REG_TOKEN} --labels test-self-runner --ephemeral
./run.sh
