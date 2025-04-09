FROM ubuntu:24.04

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

# download and extract the linux x64 runner
RUN curl -o actions-runner-linux-x64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-x64-2.323.0.tar.gz
RUN echo "0dbc9bf5a58620fc52cb6cc0448abcca964a8d74b5f39773b7afcad9ab691e19  actions-runner-linux-x64-2.323.0.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-x64-2.323.0.tar.gz

WORKDIR /
COPY . .

USER root
RUN chown github:github start_runner.sh
RUN chmod +x start_runner.sh
USER github

ENTRYPOINT ["/bin/bash", "start_runner.sh"]
