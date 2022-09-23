terraform {
    required_providers {
        oci = {
            source = "hashicorp/oci"
            version = ">= 4.0.0"
        }
    }
    backend "s3" {
        bucket = "always-free-kubernetes-tfstate"
        key = "k8s-alwaysfree"
        region = "uk-london-1"
        endpoint = "https://lr2pg7navww8.compat.objectstorage.uk-london-1.oraclecloud.com"
        shared_credentials_file = "~/.oci/credentials"
        skip_region_validation = true
        skip_credentials_validation = true
        skip_metadata_api_check = true
        force_path_style = true
    }
}

provider "oci" {
   auth = "APIKey"
   config_file_profile = "default" 
}