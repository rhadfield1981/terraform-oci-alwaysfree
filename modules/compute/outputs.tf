output "os-image-id" {
    description = "ID of latest Ubuntu Image for compute"
    value = data.oci_core_images.ubuntu-images.images[0].id
}

output "compute-shape" {
    description = "Shapes available to host the OS image"
    value = data.oci_core_shapes.compute-shapes

}

output "availability-domains" {
    description = "Availability Domains available"
    value= data.oci_identity_availability_domains.availability-domains
}

output "private-key" {
    description = "Not secure investigate porting to terraform vault in future"
    value = tls_private_key.kubernetes-ssh-key.private_key_pem
    sensitive = true
}

output "public-key" {
    description = "Public key, useful for debugging, move to tf vault in future"
    value = tls_private_key.kubernetes-ssh-key.public_key_pem
}