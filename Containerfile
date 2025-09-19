FROM quay.io/fedora/fedora-bootc:latest

RUN dnf update -y

#include unit files and containers
ADD etc etc
ADD usr usr

RUN dnf5 install -y dnf5-plugins dnf-plugins-core

# Install bottom process monitor
RUN dnf copr enable atim/bottom -y
RUN dnf install -y bottom
# Install git and GitHub CLI
RUN dnf install -y git
RUN dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
RUN dnf install -y gh --repo gh-cli
# Nushell
RUN echo "[gemfury-nushell] \
    name=Gemfury Nushell Repo \
    baseurl=https://yum.fury.io/nushell/ \
    enabled=1 \
    gpgcheck=0 \
    gpgkey=https://yum.fury.io/nushell/gpg.key" | sudo tee /etc/yum.repos.d/fury-nushell.repo
RUN dnf install -y nushell
RUN dnf clean all
