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
    security_list_ids = [oci_core_security_list.public-sl.id]
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
    security_list_ids = [oci_core_security_list.private-sl.id]
    freeform_tags = { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
}

#Define protocols as locals as this will not change unless an update to
#OCI terraform definition of oci_core_security_list
locals {
  protocols = {
    icmp    = 1
    tcp     = 6
  }
}

resource "oci_core_security_list" "private-sl" {
  compartment_id = var.compartment-id
  vcn_id = oci_core_vcn.vcn.id
  display_name = join("-", ["private",var.sl-display-name])
  
#Iterate through list of egress rules to minimise code
  dynamic "egress_security_rules" {
    for_each = var.priv-security-list-rules.rules.egress_rules
    
    content {
      destination = egress_security_rules.value["destination"]
      protocol = local.protocols.tcp
      description = egress_security_rules.key
      tcp_options {
        max = egress_security_rules.value["max-port"]
        min = egress_security_rules.value["min-port"]
      }
    }
  }
#Iterate through list of ingress rules to minimise code
  dynamic "ingress_security_rules" {
    for_each = var.priv-security-list-rules.rules.ingress_rules
    
    content {
      protocol = local.protocols.tcp
      source =  ingress_security_rules.value["source"]
      description = ingress_security_rules.key
      tcp_options {
        max = ingress_security_rules.value["max-port"]
        min = ingress_security_rules.value["min-port"]
      }        
    }
  }
}

resource "oci_core_security_list" "public-sl" {
  compartment_id = var.compartment-id
  vcn_id = oci_core_vcn.vcn.id
  display_name = join("-", ["public",var.sl-display-name])
  
#Iterate through list of egress rules to minimise code
  dynamic "egress_security_rules" {
    for_each = var.pub-security-list-rules.rules.egress_rules
    
    content {
      destination = egress_security_rules.value["destination"]
      protocol = local.protocols.tcp
      description = egress_security_rules.key
      tcp_options {
        max = egress_security_rules.value["max-port"]
        min = egress_security_rules.value["min-port"]
      }
    }
  }
#Iterate through list of ingress rules to minimise code
  dynamic "ingress_security_rules" {
    for_each = var.pub-security-list-rules.rules.ingress_rules
    
    content {
      protocol = local.protocols.tcp
      source =  ingress_security_rules.value["source"]
      description = ingress_security_rules.key
      tcp_options {
        max = ingress_security_rules.value["max-port"]
        min = ingress_security_rules.value["min-port"]
      }        
    }
  }
}