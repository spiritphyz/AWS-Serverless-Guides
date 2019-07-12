# AWS CLI Cheatsheet
Listed below are example CLI commands you can use to "copy, paste, configure, commit command". The examples plainly list the fussy options needed to quickly configure Amazon Web Services without using the web-based Management Console.

## Requirements
 * [CLI tools are installed](./000-Setting-Up-AWS-CLI-Tools.md)
 * IAM identities are configured
 * IAM keys are in your path

---

# Create a new public bucket

### 1. Set public permissions, set region
  * You can't use `--region` by itself for regions not in `us-east-1`; you also need the `LocationConstraint` option.
  * Replace `example.com` below with the name of your S3 bucket.
  ```bash
  # For us-east-1
  aws s3api create-bucket --bucket example.com --acl public-read --region us-east-1

  # For regions not in us-east-1
  aws s3api create-bucket --bucket example.com --acl public-read --region us-west-1 --create-bucket-configuration LocationConstraint=us-west-1
  ```

### 2. Enable Static Website Hosting, set defaults for the Index and Error objects
  * If necessary, customize the target files for `index-document` and `error-document`
  * Replace the `example.com` bucket name
```bash
aws s3 website s3://example.com --index-document index.html --error-document index.html
```

### 3. Get public-read policy and save it to home folder
  * Downloading of the `.json` template only needs to be done once
  * The master `.json` file will be will be saved to: `~/aws-policies/s3/`
```bash
curl -o ~/aws-policies/s3-bucket-public-read.json --create-dirs https://raw.githubusercontent.com/spiritphyz/aws-policies/master/s3/s3-bucket-public-read.json
```

### 4. Customize the policy the bucket name to 'example.com'
  * We will duplicate the original master policy as a new file named `s3.json`
  * In the `sed` command below, customize the `example.com` bucket name:
```bash
sed 's/YOURBUCKETNAME/example.com/g' ~/aws-policies/s3-bucket-public-read.json > s3.json
```

### 5. Add bucket policy to S3
  * We will use the customized `s3.json` in Step 4 for the bucket permission rules
  * Replace the `example.com` bucket name:
```bash
aws s3api put-bucket-policy --bucket example.com --policy file://s3.json
```
