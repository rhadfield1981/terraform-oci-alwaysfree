# Create VCN
resource "oci_core_vcn" "vcn" {
    compartment_id = var.compartment-id
    
    cidr_block = var.vcn-cidr-block
    display_name = join("-", [var.display-name,"vcn"])
    dns_label = lower(var.display-name)
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }

}

resource "oci_core_route_table" "rt" {
    compartment_id = var.compartment-id
    vcn_id = oci_core_vcn.vcn.id

    display_name = join("-", [var.display-name, "rt"])
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
    route_rules {
        network_entity_id = oci_core_internet_gateway.igw.id
        destination = "0.0.0.0/0"
    }
}

resource "oci_core_internet_gateway" "igw" {
    compartment_id = var.compartment-id
    vcn_id = oci_core_vcn.vcn.id

    display_name = join("-", [var.display-name, "igw"])
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
}

resource "oci_core_subnet" "public-subnet" {
    compartment_id = var.compartment-id
    vcn_id = oci_core_vcn.vcn.id
    cidr_block = var.public-subnet-cidr-block

    display_name = join("-", [var.display-name, "pub-sub"])
    dns_label = "public"
    prohibit_public_ip_on_vnic = false
    prohibit_internet_ingress = false
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }

}

resource "oci_core_route_table_attachment" "rta" {
    subnet_id = oci_core_subnet.public-subnet.id
    route_table_id = oci_core_route_table.rt.id
} 

resource "oci_core_subnet" "private-subnet" {
compartment_id = var.compartment-id
    vcn_id = oci_core_vcn.vcn.id
    cidr_block = var.private-subnet-cidr-block

    display_name = join("-", [var.display-name, "priv-sub"])
    dns_label = "private"
    prohibit_public_ip_on_vnic = true
    prohibit_internet_ingress = true
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
}