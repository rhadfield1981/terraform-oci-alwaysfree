output "os-image-id" {
    description = "ID of latest Ubuntu Image for compute"
    value = data.oci_core_images.ubuntu-images.images[0].id
}

output "limited-free-compute-shapes" {
    description = "Shapes available to host the OS image"
    value = data.oci_core_shapes.limited-free-compute-shapes

}

output "always-free-compute-shapes" {
    description = "Shapes available to host the OS image"
    value = data.oci_core_shapes.always-free-compute-shapes

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

output "compute-hosts" {
    description = "All compute details"
    value = zipmap([for instance in oci_core_instance.instance : instance.private_ip ], [for instance in oci_core_instance.instance : instance.display_name ])
}

output "public-hosts" {
    description = "All compute details"
    value = zipmap([for instance in oci_core_instance.instance : instance.display_name if instance.create_vnic_details[0].assign_public_ip != "false" ], [for instance in oci_core_instance.instance : join(": ", ["ansible_host",instance.public_ip]) if instance.public_ip != "" ]) 
}
