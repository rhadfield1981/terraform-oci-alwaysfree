variable compartment-id {
    description = "Compartment to host compute"
    type = string
}

variable private-subnet-id {
    description = "Private subnet id for non public instances"
    type = string
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
