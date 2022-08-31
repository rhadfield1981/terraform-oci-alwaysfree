# Get root compartment ID
data "oci_identity_tenancy" "root-compartment" {
    tenancy_id = "<tenancy-ocid>"
}

# Create a compartment to hold all our kubernetes resources
resource "oci_identity_compartment" "kube-compartment" {
    compartment_id = data.oci_identity_tenancy.root-compartment.id
    description = "${var.compartment_description}"
    name = "${var.compartment_name}"
}

