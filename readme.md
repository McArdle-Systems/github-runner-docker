# A Github Actions Runner for Docker

### Environment variables
Set these variables to configure the runner:

```
RUNNER_TOKEN=github_runner_token
RUNNER_URL=github_runner_url
RUNNER_NAME=github_runner_name
```

### Volumes
Mount a named volume to persist configuration if you don't want to reconfigure the token every time.

```
-v actions-runner:/actions-runner
```

### Usage
Sample usage from cli:

```
docker run -d -v actions-runner:/actions-runner -e RUNNER_TOKEN=github_runner_token -e RUNNER_URL=github_runner_url -e RUNNER_NAME=github_runner_name github-runner-docker:amd64
```
