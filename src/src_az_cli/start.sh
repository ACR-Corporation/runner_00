#!/bin/bash
REPO=$REPO
ACCESS_TOKEN=$TOKEN

REG_TOKEN=$(curl -X POST -H "Authorization: token ${ACCESS_TOKEN}" -H "Accept: application/vnd.github+json" https://api.github.com/repos/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --url https://github.com/${REPO} --token ${REG_TOKEN} --ephemeral

./run.sh & wait $!