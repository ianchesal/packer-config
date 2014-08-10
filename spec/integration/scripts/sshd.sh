#!/bin/bash -eux

# From: https://github.com/opscode/bento

echo "UseDNS no" >> /etc/ssh/sshd_config
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config