#!/bin/bash
cd ../
terraform output public-hosts | sed -E 's/\{|\}|"|\=//g' | awk '{print $3" " $1}' | sudo tee -a /etc/hosts
