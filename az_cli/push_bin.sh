az vm extension set \
   --resource-group rg_runner \
   --vm-name runner \
   --name customScript \
   --publisher Microsoft.Azure.Extensions \
   --settings '{"commandToExecute": "sudo apt-get install jq -y \
                 && cd /home/pierrc && mkdir actions-runner \
                 && cd actions-runner \
                 && curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
                 && tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz \
                 && sudo chown -R pierrc ~pierrc"
                }'