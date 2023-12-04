#!/bin/bash
REPO_URL=$1
TOKEN=$2
mkdir actions-runner 
cd actions-runner 
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz 
tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz 
export RUNNER_ALLOW_RUNASROOT=\"1\"
 ./config.sh --url "$REPO_URL" --token "$TOKEN"
./run.sh
