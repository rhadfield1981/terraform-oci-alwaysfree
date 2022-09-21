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

data "oci_identity_availability_domain" "availability-domains" {
    compartment_id = var.compartment-id
}

resource "oci_core_instance" "mysql-k3s" {
    compartment_id = var.compartment-id
    shape = data.oci_core_shapes.compute-shapes.shapes[0].name
    availability_domain=data.oci_identity_availability_domain.availability-domains[0].id
    display_name = "mysql-k3s"
    freeform_tags =  { "app"= var.ff-tags.app, "cost"= var.ff-tags.cost }
    shape_config {

    }
    source_details {
      source_id = data.oci_core_images.ubuntu-images.
      source_type="image"
    }
}



