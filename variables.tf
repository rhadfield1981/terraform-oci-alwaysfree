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