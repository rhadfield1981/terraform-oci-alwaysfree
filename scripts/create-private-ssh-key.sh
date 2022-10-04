#!/bin/bash
cd ../
terraform output -raw private-key >  ~/.oci/oci_api_key.pem
chmod 0600 ~/.oci/oci_api_key.pem
