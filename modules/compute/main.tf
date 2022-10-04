data "oci_core_shapes" "always-free-compute-shapes" {
  compartment_id=var.compartment-id

  filter {
    name = "billing_type"
    values = ["ALWAYS_FREE"]
  }  
}

data "oci_core_shapes" "limited-free-compute-shapes" {
  compartment_id=var.compartment-id

  filter {
    name = "billing_type"
    values = ["LIMITED_FREE"]
  } 
}

data "oci_core_images" "ubuntu-images" {
  compartment_id= var.compartment-id
  operating_system="Canonical Ubuntu"
  operating_system_version="20.04"
  shape = data.oci_core_shapes.always-free-compute-shapes.shapes[0].name
  sort_by="TIMECREATED"
  sort_order="DESC"
}

data "oci_core_images" "arm-ubuntu-images" {
  compartment_id= var.compartment-id
  operating_system="Canonical Ubuntu"
  operating_system_version="20.04"
  shape = data.oci_core_shapes.limited-free-compute-shapes.shapes[0].name
  sort_by="TIMECREATED"
  sort_order="DESC"
}


data "oci_identity_availability_domains" "availability-domains" {
    compartment_id = var.compartment-id
}

resource "tls_private_key" "kubernetes-ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "oci_core_instance" "instance" {
  for_each = var.instances
    compartment_id = var.compartment-id
    shape = each.value["billing-type"] == "ALWAYS_FREE" ? data.oci_core_shapes.always-free-compute-shapes.shapes[0].name : data.oci_core_shapes.limited-free-compute-shapes.shapes[0].name 
    availability_domain=data.oci_identity_availability_domains.availability-domains.availability_domains[1].name
    display_name = each.key
    shape_config {
      ocpus = 1
      memory_in_gbs =  each.value["billing-type"] == "ALWAYS_FREE" ? 1 : 6
    }
    create_vnic_details {
      subnet_id = each.value["assign-public-ip"] ? var.public-subnet-id : var.private-subnet-id
      assign_public_ip = each.value["assign-public-ip"]
      skip_source_dest_check = false
    }
    freeform_tags =  { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
    source_details {
      source_id = each.value["billing-type"] == "ALWAYS_FREE" ? data.oci_core_images.ubuntu-images.images[0].id : data.oci_core_images.arm-ubuntu-images.images[0].id
      source_type="image"
    }
    metadata = {
      ssh_authorized_keys = tls_private_key.kubernetes-ssh-key.public_key_openssh
    }
}





