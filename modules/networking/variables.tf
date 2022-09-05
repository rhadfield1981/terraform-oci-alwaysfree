variable "compartment-id" {
    description = "Compartment to host networking components"
    type = string
}

variable "display-name" {
    description = "Display name for resources"
    type = string
    default = "kubernetes"
}

variable "vcn-cidr-block" {
    description = "CIDR Block for the VCN"
    type = string
    default = "10.0.0.0/16"
}

variable "public-subnet-cidr-block" {
    description = "Network address range for public subnet"
    type = string
    default = "10.0.0.0/24"
}

variable "private-subnet-cidr-block" {
    description = "Network address range for private subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "ff-tags" {
    description = "Freeform tags to apply to resources"
    type = object({
        app = string,
        cost = string
    })
    default = {
            app = "kubernetes"
            cost = "always-free"
        }
}
