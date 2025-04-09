FROM ubuntu:24.04

ENV RUNNER_TOKEN=
ENV RUNNER_URL=
ENV RUNNER_NAME=GITHUB_RUNNER

VOLUME /actions-runner

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libicu-dev ca-certificates curl perl

# # Docker stuff
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#     ca-certificates curl
# RUN install -m 0755 -d /etc/apt/keyrings
# RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
# RUN chmod a+r /etc/apt/keyrings/docker.asc
# RUN echo \
#     "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#     $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
#     tee /etc/apt/sources.list.d/docker.list > /dev/null
# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \
#     docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

RUN mkdir /actions-runner
RUN mkdir /home/github

WORKDIR /actions-runner

# download and extract the linux x64 runner
RUN curl -o actions-runner-linux-x64-2.323.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-linux-x64-2.323.0.tar.gz
RUN echo "0dbc9bf5a58620fc52cb6cc0448abcca964a8d74b5f39773b7afcad9ab691e19  actions-runner-linux-x64-2.323.0.tar.gz" | shasum -a 256 -c
RUN tar xzf ./actions-runner-linux-x64-2.323.0.tar.gz
RUN /actions-runner/bin/installdependencies.sh

RUN groupadd -r github && useradd --no-log-init -r -g github github
# RUN usermod -aG docker github

RUN chown github:github /actions-runner
RUN chown github:github /home/github

RUN chmod u+x /actions-runner
RUN chmod u+x /home/github


USER github
WORKDIR /
COPY . .

USER root
RUN chown github:github start_runner.sh
RUN chmod +x start_runner.sh

USER github
ENTRYPOINT ["/bin/bash", "start_runner.sh"]
