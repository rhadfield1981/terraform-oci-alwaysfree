variable "user-id" {
    description = "OCID of user to assign S3 style private token to"
    type = string
}

variable "object-storage-secret-key" {
    description = "Display name for s3 style authentication secret key"
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
