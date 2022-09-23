data "oci_core_images" "ubuntu-images" {
  compartment_id= var.compartment-id
  operating_system="Canonical Ubuntu"
  operating_system_version="20.04"
  sort_by="TIMECREATED"
  sort_order="DESC"
}

data "oci_core_shapes" "compute-shapes" {
  compartment_id=var.compartment-id
  image_id=data.oci_core_images.ubuntu-images.images[0].id

  lifecycle {
    postcondition {
      condition = self.shapes[0].billing_type == "ALWAYS_FREE"
      error_message = "No ALWAYS FREE shapes found"
    }
  }
  
}

data "oci_identity_availability_domains" "availability-domains" {
    compartment_id = var.compartment-id
}

resource "tls_private_key" "kubernetes-ssh-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "oci_core_instance" "mysql-k3s" {
    compartment_id = var.compartment-id
    shape = data.oci_core_shapes.compute-shapes.shapes[0].name
    availability_domain=data.oci_identity_availability_domains.availability-domains.availability_domains[0].name
    display_name = "mysql-k3s"
    create_vnic_details {
      subnet_id = var.private-subnet-id
      assign_public_ip = "false"
    }
    freeform_tags =  { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
    source_details {
      source_id = data.oci_core_images.ubuntu-images.images[0].id
      source_type="image"
    }
    metadata = {
      ssh_authorized_keys = tls_private_key.kubernetes-ssh-key.public_key_openssh
    }
}



