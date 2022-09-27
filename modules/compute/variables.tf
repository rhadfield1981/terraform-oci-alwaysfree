variable "compartment-id" {
    description = "Compartment to host compute"
    type = string
}

variable "instances" {
    description = "Map of objects defining compute instances"
    type = map(object({
        subnet-id = string
        billing-type = string
        assign-public-ip = bool
    }))
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
