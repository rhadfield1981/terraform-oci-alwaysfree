#!/bin/bash
cd ../
echo -e "control_plane:\n  hosts:" > ../ansible/inventory.yaml
terraform output public-hosts | grep control-plane | awk '{print "    "$1":\n      "$3" "$4}' | sed 's/\"//g' >> ../ansible/inventory.yaml
echo -e "  vars:\n    ansible_user: ubuntu" >> ../ansible/inventory.yaml
echo -e "workers:\n  hosts:" >> ../ansible/inventory.yaml
terraform output public-hosts | grep worker | awk '{print "    "$1":\n      "$3" "$4}' | sed 's/\"//g' >> ../ansible/inventory.yaml
echo -e "  vars:\n    ansible_user: ubuntu" >> ../ansible/inventory.yaml

