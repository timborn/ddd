#!/usr/bin/env bash
set -e

echo "### executing $0"

echo "Install TigerVNC Server"
wget https://dl.bintray.com/tigervnc/stable/tigervnc-el7.repo -O /etc/yum.repos.d/tigervnc.repo
yum -y install tigervnc-server
yum clean all && rm -rf /var/cache/yum
