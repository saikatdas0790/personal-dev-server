FROM quay.io/fedora/fedora-bootc:latest

RUN dnf update -y

#include unit files and containers
ADD etc etc
ADD usr usr

# Install bottom process monitor
RUN dnf5 install -y dnf5-plugins dnf-plugins-core
RUN dnf copr enable atim/bottom -y
RUN dnf install -y bottom
RUN dnf install -y git
RUN dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
RUN dnf install -y gh --repo gh-cli
RUN dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
RUN dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
RUN systemctl enable docker
RUN dnf clean all
