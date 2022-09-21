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