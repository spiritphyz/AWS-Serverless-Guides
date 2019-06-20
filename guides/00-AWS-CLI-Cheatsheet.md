# CLI commands for making a bucket with a public-read policy and enabling Static Website Hosting

### Create a bucket with public-read ACL and region in `us-west-1`
  * Note: you can't use `--region` by itself for regions not in `us-east-1`. You also need the `LocationConstraint` option.
  ```bash
  aws s3api create-bucket --bucket example.com --acl public-read --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1
  ```

### Enable Static Website Hosting and set defaults for the Index and Error objects
  * The naming convention below uses "example.com" as the name of the S3 bucket.
```bash
aws s3 website s3://example.com --index-document index.html --error-document index.html
```

### Get public-read policy and save it to home folder
```bash
curl -o ~/aws-policies/s3-bucket-public-read.json --create-dirs https://raw.githubusercontent.com/spiritphyz/aws-policies/master/s3/s3-bucket-public-read.json
```

# Customize and create a local copy of the S3 public-read policy by renaming the bucket name to 'example.com' sed 's/YOURBUCKETNAME/example.com/g' ~/aws-policies/s3-bucket-public-read.json > s3.json

# Add bucket policy aws s3api put-bucket-policy --bucket example.com --policy file://s3.json
