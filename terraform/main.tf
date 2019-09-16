// Architecture defaults listed at:
// https://github.com/spiritphyz/AWS-Serverless-Guides

// Use AWS as the cloud provider.
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

resource "aws_s3_bucket" "www" {
	bucket = "${var.www_domain_name}"
	acl    = "public-read"
	policy = <<POLICY
	{
		"Version":"2012-10-17",
		"Statement":[
			{
				"Sid":"AddPerm",
				"Effect":"Allow",
				"Principal": "*",
				"Action":["s3:GetObject"],
				"Resource":["arn:aws:s3:::${var.www_domain_name}/*"]
			}
		]
	}
	POLICY

	website {
		index_document = "index.html"
		error_document = "error.html"
		//error_document = "index.html"
	}
}
