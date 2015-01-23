#!/bin/bash -eu
apt-get update
apt-get install -y gcc python-dev python-pip
pip install ansible
apt-get remove -y --purge gcc
apt-get autoremove -y
