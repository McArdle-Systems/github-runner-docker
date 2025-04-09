FROM arm64v8/ubuntu:24.04

ENV RUNNER_TOKEN=
ENV RUNNER_URL=
ENV RUNNER_NAME=GITHUB_RUNNER

VOLUME /actions-runner

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libicu-dev ca-certificates curl perl


RUN mkdir /actions-runner

RUN groupadd -r github && useradd --no-log-init -r -g github github
RUN chown github:github /actions-runner
RUN chmod u+x /actions-runner

WORKDIR /actions-runner
USER github

# download and extract the linux arm64 runner
RUN curl -o actions-runner-linux-arm64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-arm64-2.323.0.tar.gz
RUN echo "9cb778fffd4c6d8bd74bc4110df7cb8c0122eb62fda30b389318b265d3ade538  actions-runner-linux-arm64-2.323.0.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-arm64-2.323.0.tar.gz

WORKDIR /
COPY . .

USER root
RUN chown github:github start_runner.sh
RUN chmod +x start_runner.sh
USER github

ENTRYPOINT ["/bin/bash", "start_runner.sh"]
