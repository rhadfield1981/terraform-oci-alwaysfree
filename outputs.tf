output "tenancy" {
    description = "Root Compartment ID"
    value = data.oci_identity_tenancy.root-compartment.tenancy_id
}

output "kube-compartment" {
    description = "Kubernetes Compartment ID"
    value = oci_identity_compartment.kube-compartment.id
}

output "os-images" {
    description = "Ubuntu Images available"
    value = module.compute.os-image-id
}

output "a1-compute-shapes" {
    description = "Compute shapes available"
    value = module.compute.limited-free-compute-shapes.shapes[0]
}

output "e2-compute-shapes" {
    description = "Compute shapes available to host os Image"
    value = module.compute.always-free-compute-shapes.shapes[0]
}

output "private-key" {
    description = "Private key to connect to compute instances.  This is not secure and should be ported to terraform vault at a later date"
    value = module.compute.private-key
    sensitive = true
}

output "public-key" {
    description = "Public key for compute instances, useful for debugging, not intended for any production environment"
    value = module.compute.public-key
}

output "compute-hosts" {
    description = "Values for compute hosts file"
    value = module.compute.compute-hosts
}

output "public-hosts" {
    description = "All public compute ips"
    value = module.compute.public-hosts
}


