FROM quay.io/fedora/fedora-bootc:latest

RUN dnf update -y

#include unit files and containers
ADD etc etc
ADD usr usr

# Install bottom process monitor
RUN dnf5 install -y dnf5-plugins
RUN dnf copr enable atim/bottom -y
RUN dnf install -y bottom
RUN dnf install -y git
RUN dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
RUN dnf install -y gh --repo gh-cli
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN dnf clean all
