data "oci_objectstorage_namespace" "my-namespace" {

}

resource "oci_identity_customer_secret_key" "tf-secret-key" {
    display_name = var.object-storage-secret-key 
    user_id = var.user-id
}


resource "oci_objectstorage_bucket" "tf-state" {
    compartment_id = var.compartment-id
    name = var.bucket-name
    #Namespace must match either the account namespace or the compartment-id
    namespace = data.oci_objectstorage_namespace.my-namespace.namespace
}