variable "user-id" {
    description = "OCID of user to assign S3 style private token to"
    type = string
}

variable "compartment-id" {
    description = "Where to place the bucket"
    type = string
}

variable "bucket-name" {
    description = "What to call the bucket - This does not have the same restriction as S3 buckets and can be non unique"
    type = string
}

variable "bucket-namespace" {
    description = "Provide a bucket namespace, this will be created at the same time as the bucket if it does not yet exist"
    type = string
}