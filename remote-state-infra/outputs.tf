output "objectstorage-namespace" {
    value = data.oci_objectstorage_namespace.my-namespace
}

output "secret_key" {
    value = oci_identity_customer_secret_key.tf-secret-key
}

output "bucket" {
    value=oci_objectstorage_bucket.tf-state
}