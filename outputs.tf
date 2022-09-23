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

output "compute-shapes-billing" {
    description = "Compute shapes available to host os Image - billing Info"
    value = module.compute.compute-shape.shapes[0].billing_type
}

output "compute-shapes-name" {
    description = "Compute shapes available to host os Image"
    value = module.compute.compute-shape.shapes[0].name
}

output "availability-domains" {
    description = "Availability Domains available"
    value= module.compute.availability-domains.availability_domains
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