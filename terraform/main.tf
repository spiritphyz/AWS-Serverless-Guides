// We're using AWS as the cloud provider.
provider "aws" {
  region = "us-west-1"
}

// Create a variable for the fully qualified domain.
variable "www_domain_name" {
  default = "www.spiritphyz.io"
}

// Create a variable for the apex domain (also called root or "naked" domain).
variable "apex_domain_name" {
  default = "spiritphyz.io"
}
