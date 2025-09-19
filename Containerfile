FROM quay.io/fedora/fedora-bootc:latest

RUN dnf update -y

#include unit files and containers
ADD etc etc
ADD usr usr

# Install bottom process monitor
RUN dnf5 install -y dnf5-command-copr
RUN dnf copr enable atim/bottom -y
RUN dnf install -y bottom
RUN dnf clean all
