resource "oci_identity_customer_secret_key" "tf-secret-key" {
    display_name = var.object-storage-secret-key 
    user_id = var.user-id
}

resource "oci_objectstorage_bucket" "tf-state" {
    compartment_id = var.compartment-id
    name = var.bucket-name
    namespace = var.bucket-namespace
    
}