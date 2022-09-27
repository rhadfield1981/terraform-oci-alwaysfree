output "vcn-id" {
    description = "VCN ID for use in other modules"
    value = oci_core_vcn.vcn.id
}

output "public-subnet-id" {
    description ="Public subnet id for use in other modules"
    value = oci_core_subnet.public-subnet.id
}

output "private-subnet-id" {
    description ="Private subnet id for use in other modules"
    value = oci_core_subnet.private-subnet.id
}

