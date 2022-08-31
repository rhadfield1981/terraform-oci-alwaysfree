output "tenancy" {
    description = "Root Compartment ID"
    value = data.oci_identity_tenancy.root-compartment.tenancy_id
}

output "kube-compartment" {
    description = "Kubernetes Compartment ID"
    value = oci_identity_compartment.kube-compartment.id
}
