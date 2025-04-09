
#!/bin/bash

echo "what in ternation is going on here. github_token isn't anywhere! what in the holy cached image build artifacts is going on here?"

# check for the token
if [[ -z "$RUNNER_TOKEN" ]]; then
    echo "You must supply the RUNNER_TOKEN environment variable for this script to work.";
    exit 2;
fi

# check for the url
if [[ -z "$RUNNER_URL" ]]; then
    echo "You must supply the RUNNER_URL environment variable for this script to work.";
    exit 3;
fi

cd /actions-runner

# configure the runner
./config.sh --unattended --url "$RUNNER_URL" --token "$RUNNER_TOKEN" --replace --name "$RUNNER_NAME"

# run it
./run.sh