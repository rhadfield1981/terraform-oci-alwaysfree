#!/bin/bash
firewall-cmd  --permanent --zone=public --add-port=6443/tcp
firewall-cmd  --permanent --zone=public --add-port=2379/tcp
firewall-cmd  --permanent --zone=public --add-port=2380/tcp
firewall-cmd  --permanent --zone=public --add-port=10257/tcp
firewall-cmd  --permanent --zone=public --add-port=10250/tcp
firewall-cmd  --permanent --zone=public --add-port=10259/tcp

firewall-cmd  --reload
