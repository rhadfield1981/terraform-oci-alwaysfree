# Get root compartment ID
data "oci_identity_tenancy" "root-compartment" {
    tenancy_id = "<tenancy-ocid>"
}

# Create a compartment to hold all our kubernetes resources
resource "oci_identity_compartment" "kube-compartment" {
    compartment_id = data.oci_identity_tenancy.root-compartment.id
    description = "${var.compartment-description}"
    name = "${var.compartment-name}"
}

module "networking" {
    source = "./modules/networking"

    #Use defaults in modules/networking/variables.tf or provide new values below
    #display-name = 
    #vcn-cidr-block=
    #public-subnet-cidr-block=
    #private-subnet-cidr-block=
    #ff-tags=
}
