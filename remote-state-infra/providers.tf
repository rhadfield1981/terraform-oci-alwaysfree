terraform {
    required_providers {
        oci = {
            source = "hashicorp/oci"
            version = ">= 4.0.0"
        }
    }
}

provider "oci" {
   auth = "APIKey"
   config_file_profile = "default" 
}