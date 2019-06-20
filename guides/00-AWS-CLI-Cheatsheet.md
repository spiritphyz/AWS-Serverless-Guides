# CLI commands for making a bucket with a public-read policy and enabling Static Website Hosting

### Create a bucket with public-read ACL and region in us-west-1
  * You can't use --region by itself for regions not in us-east-1
  ```bash
  aws s3api create-bucket --bucket hodgkinhub.com --acl public-read --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1
  ```

# Enable Static Website Hosting and set default objects aws s3 website s3://hodgkinhub.com --index-document index.html --error-document index.html

# Get public-read policy and save it to home folder curl -o ~/aws-policies/s3-bucket-public-read.json --create-dirs https://raw.githubusercontent.com/GiantAgency/aws-policies/master/s3/s3bucket-public-read.json

# Customize and create a local copy of the S3 public-read policy by renaming the bucket name to 'hodgkinhub.com' sed 's/YOURBUCKETNAME/hodgkinhub.com/g' ~/aws-policies/s3-bucket-public-read.json > s3.json

# Add bucket policy aws s3api put-bucket-policy --bucket hodgkinhub.com --policy file://s3.json
