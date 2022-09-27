variable "region" {
    type = string
    description = "Region in which to create OCI resources"
    default = "uk-london-1"
}

variable "compartment-description" {
    type = string
    description = "Text describing the purpose of the compartment"
}

variable "compartment-name" {
    type = string  
    description = "Name of the compartment"
}

variable "priv-security-list-rules" {
    description = "Map of objects for defining private security list ingress/egress rules"
    type = map(object({
        egress_rules = map(object({
            destination = string
            max-port = number
            min-port = number
        }))
        ingress_rules = map(object({
            source = string
            max-port = number
            min-port = number
        }))
    }))
}

variable "pub-security-list-rules" {
    description = "Map of objects for defining public security list ingress/egress rules"
    type = map(object({
        egress_rules = map(object({
            destination = string
            max-port = number
            min-port = number
        }))
        ingress_rules = map(object({
            source = string
            max-port = number
            min-port = number
        }))
    }))
}
