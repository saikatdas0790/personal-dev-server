FROM quay.io/fedora/fedora-bootc:latest

RUN dnf update -y && dnf clean all

#include unit files and containers
ADD etc etc
ADD usr usr

# Fetch the file from the URL, unzip and place it in /usr/local/bin and remove the zip file
# Change the URL to the desired file location
RUN dnf install -y unzip && dnf clean all
ADD https://github.com/SiaFoundation/walletd/releases/download/v2.10.5/walletd_linux_amd64.zip /usr/local/bin/walletd_linux_amd64.zip
RUN unzip /usr/local/bin/walletd_linux_amd64.zip -d /usr/local/bin/ && rm /usr/local/bin/walletd_linux_amd64.zip
RUN chmod +x /usr/local/bin/walletd
RUN ls -al /usr/local/bin/walletd

EXPOSE 9980
EXPOSE 9981
EXPOSE 9982
EXPOSE 9983

# Install cockpit and enable the socket
RUN dnf install -y cockpit pcp tmux screen && dnf clean all
RUN systemctl enable cockpit.socket

# RUN dnf install -y cockpit cockpit-podman cockpit-storaged cockpit-ws git lm_sensors sysstat tuned bash-completion && dnf clean all

#enable desired units
# RUN systemctl enable lm_sensors sysstat tuned fstrim.timer podman.socket podman-auto-update.timer cockpit.socket