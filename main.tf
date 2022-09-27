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

    compartment-id = oci_identity_compartment.kube-compartment.id

    pub-security-list-rules = var.pub-security-list-rules
    priv-security-list-rules = var.priv-security-list-rules
    #Use defaults in modules/networking/variables.tf or provide new values below
    #display-name = 
    #vcn-cidr-block=
    #public-subnet-cidr-block=
    #private-subnet-cidr-block=
    #ff-tags=
}

module "compute" {
    source = "./modules/compute"

    compartment-id = oci_identity_compartment.kube-compartment.id
    instances = {
        # Source article suggests installing these instances, however they do not appear to be used
        # Also we hit our always free storage limit of 200GB with more than 4 instances
        #mysql-k3s = {
        #    subnet-id = module.networking.private-subnet-id
        #    billing-type = "ALWAYS_FREE"
        #    assign-public-ip = "false"
        #}
        #rabbitmq = {
        #    subnet-id = module.networking.private-subnet-id
        #    billing-type = "ALWAYS_FREE"
        #    assign-public-ip = "false"
        #}
        control-plane-01 = {
            subnet-id = module.networking.public-subnet-id
            billing-type = "LIMITED_FREE"
            assign-public-ip = "true"
        }
        control-plane-02 = {
            subnet-id = module.networking.public-subnet-id
            billing-type = "LIMITED_FREE"
            assign-public-ip = "true"
        }
        worker-node-01 = {
            subnet-id = module.networking.private-subnet-id
            billing-type = "LIMITED_FREE"
            assign-public-ip = "false"
        }
        worker-node-02 = {
            subnet-id = module.networking.private-subnet-id
            billing-type = "LIMITED_FREE"
            assign-public-ip = "false"
        }

    }
    
}
