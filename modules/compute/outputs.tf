output "os-image-id" {
    description = "ID of latest Ubuntu Image for compute"
    value = data.oci_core_images.ubuntu-images.images[0].id
}

output "compute-shape" {
    description = "Shapes available to host the OS image"
    value = data.oci_core_shapes.compute-shapes

}