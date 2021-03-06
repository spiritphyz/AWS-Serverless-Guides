# AWS CLI Cheatsheet
Listed below are example CLI commands you can use to "copy, paste, configure, then commit the command". The fussy options are listed as a starting template for you to quickly configure Amazon Web Services without using the web-based Management Console.

## Requirements
 * [CLI tools are installed](./Setting-Up-AWS-CLI-Tools.md)
 * [IAM users and groups are configured](./Setting-Up-IAM-Identities-for-CLI.md#create-a-group-with-limited-admin-privileges)
 * [Stored credentials are configured](./Setting-Up-IAM-Identities-for-CLI.md#setting-up-stored-credentials-with-cli)

## Index of CLI commands in this guide
 - [ ] [**Create a new public bucket**](./AWS-CLI-Cheatsheet.md#create-a-new-public-bucket)
   * [Set public permissions, set region](./AWS-CLI-Cheatsheet.md#1-set-public-permissions-set-region)
   * [Enable Static Website Hosting, set defaults for the Index and Error objects](./AWS-CLI-Cheatsheet.md#2-enable-static-website-hosting-set-defaults-for-the-index-and-error-objects)
   * [Get public-read policy and save it to home folder](./AWS-CLI-Cheatsheet.md#3-get-public-read-policy-and-save-it-to-home-folder)
   * [Customize the policy, change bucket name to 'example.com'](./AWS-CLI-Cheatsheet.md#4-customize-the-policy-change-bucket-name-to-examplecom)
   * [Add bucket policy to S3](./AWS-CLI-Cheatsheet.md#5-add-bucket-policy-to-s3)
 - [ ] [**Sync to S3**](./AWS-CLI-Cheatsheet.md#sync-to-s3)
 - [ ] [**Create a CloudFront invalidation**](./AWS-CLI-Cheatsheet.md#create-a-cloudfront-invalidation)
 - [ ] [**Delete a bucket**](./AWS-CLI-Cheatsheet.md#delete-a-bucket)

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

### 4. Customize the policy, change bucket name to 'example.com'
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
---

# Sync to S3
  * Replace `example.com` below with the name of your S3 bucket
  * `aws sync` shares the same options as the Unix `rsync` tool
```bash
# Sync contents of directory "public" to destination bucket "example.com"
aws s3 sync --delete --exclude '*.DS_Store' public/ s3://example.com

# Sync to S3 using alternate profile.
# See the guide "Setting-Up-IAM-Identities-for-CLI.md" for setup.
aws s3 --profile qateam sync --delete public/ s3://example.com
```

---

# Create a CloudFront invalidation
  * Replace the distribution ID below
```bash
# Typing command directly into terminal:
aws cloudfront create-invalidation --distribution-id D0DISTRBID000D --paths /\*

# As part of a JSON file (like package.json), you need to escape the backslash character:
"scripts": { "invalidate:cf": "aws cloudfront create-invalidation --distribution-id D0DISTRBID000D --paths /\\*" }
```

---

# Delete a bucket
  * All objects in the bucket must be deleted before the bucket can be deleted
  * Replace `example.com` below with the name of your bucket
  * The `region` parameter is optional
```bash
# First, remove all bucket objects
aws s3 rm s3://example.com --recursive

# Then remove the bucket
aws s3api delete-bucket --bucket example.com --region us-west-1
```

---

# Resources
**S3 documentation**
  * https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html
  * https://docs.aws.amazon.com/cli/latest/reference/s3api/delete-bucket.html
  * https://docs.aws.amazon.com/AmazonS3/latest/dev/delete-or-empty-bucket.html#empty-bucket-awscli
  * https://docs.aws.amazon.com/cli/latest/reference/s3/website.html
  * https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-policy.html
  * https://stackoverflow.com/questions/39466716/how-do-i-get-the-aws-s3-website-endpoint-url-through-the-api

**CloudFront documentation**
  * https://docs.aws.amazon.com/cli/latest/reference/cloudfront/create-invalidation.html
  * https://kylewbanks.com/blog/invalidate-entire-cloudfront-distribution-from-command-line
