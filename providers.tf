terraform {
    required_providers {
        oci = {
            source = "oracle/oci"
            version = "~> 4.0"
        }
    }
}


provider "oci" {
   auth = "APIKey"
   config_file_profile = "default" 
}