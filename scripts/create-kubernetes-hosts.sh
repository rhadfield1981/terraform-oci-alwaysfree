#!/bin/bash
cd ../
terraform output compute-hosts | sed -E 's/"|=|\{|\}//g' | sed 's/^[[:space:]]*//' > ../ansible/resources/kubernetes-hosts.tmp
