#!/bin/bash
set -e

# Check if RAID already exists
if [ ! -e /dev/md0 ]; then
  # Create RAID 0 array
  mdadm --create --verbose /dev/md0 --level=0 --raid-devices=2 /dev/sda /dev/sdb
  # Create filesystem (ext4)
  mkfs.ext4 /dev/md0
fi

# Mount RAID array
mkdir -p /mnt/raid0
mount /dev/md0 /mnt/raid0

# Optionally add to /etc/fstab if not present
if ! grep -q '/dev/md0' /etc/fstab; then
  echo '/dev/md0 /mnt/raid0 ext4 defaults 0 0' >> /etc/fstab
fi
