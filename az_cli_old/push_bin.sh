az vm extension set \
   --resource-group rg_runner \
   --vm-name runner \
   --name customScript \
   --publisher Microsoft.Azure.Extensions \
   --settings '{"commandToExecute": "sudo apt-get install jq -y \
                 && VERSION=2.311.0 \
                 && REPO=ACR-Corporation/runner_00 \
                 && ACCESS_TOKEN=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 \
                 && cd /home/pierrc && mkdir actions-runner \
                 && cd actions-runner \
                 && curl -o actions-runner-linux-x64-${VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${VERSION}/actions-runner-linux-x64-${VERSION}.tar.gz \
                 && tar xzf ./actions-runner-linux-x64-${VERSION}.tar.gz \
                 && sudo chown -R pierrc ~pierrc"
               }'