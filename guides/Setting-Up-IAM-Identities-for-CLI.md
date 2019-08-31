# Using AWS CLI with stored credentials
Store your AWS credentials on your local machine for the CLI tools to authenticate to your company's AWS resources. Group and individual privileges are managed in Identity and Access Management.

You should configure groups and users to have compartmentalized access. If keys are compromised, the scope of damage will be limited by the narrow scope of the user or its group.

## Create a group with limited admin privileges
For the purposes of this guide, "devteam" will represent the group for individual developers that has shared privileges. This group will have administrative policies to manage S3 and CloudFront.
1. Log into the management console, [search for IAM](https://console.aws.amazon.com/iam/home)
2. Create New Group > Group Name: devteam > "Next Step" button
3. Attach Policy > Filter: policy type
    * Search for "s3"
    * Enable checkbox for "AmazonS3FullAccess"
4. Attach Policy > Filter: policy type
    * Search for "cloudfront"
    * Enable checkbox for "CloudFrontFullAccess"
5. "Next Step" button
6. Review > Confirm there are 2 policies attached > "Create Group" button

## Create a user as part of a group
Each AWS user on your team can be added to "devteam".

1. Log into the management console, [search for IAM](https://console.aws.amazon.com/iam/home?region=us-west-2#/home)

2. Click on Users > "Add User" button
    * User name: fname-lname-role
    * Access type: Programmatic access
    * "Next: Permissions" button

3. "Add user to group" button > "devteam" checkbox > "Next: Tags" button > "Next: Review" button > "Create user" button

4. Save your "Access Key ID" and "Secret Access Key", it **will only be shown once**!
    * You will paste the Accey Key ID and the Secret Access Key into the `aws configure` command below.

## Setting up stored credentials with CLI
Run the configure command. Some example options are shown below.
```bash
aws configure
```
```bash
AWS Access Key ID: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-1

Default output format [None]: json
```

After finishing, the configure command will store your creds in `~/.aws/credentials` and settings for the default profile in `~/.aws/config`:

**~/.aws/credentials**
```bash
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

**~/.aws/config**
```bash
[default]
region=us-west-1
output=json
```

## Using multiple profiles
You can edit the above 2 files to configure multiple keys. For example, the S3 sync command below contains a switch to a separate profile:
```bash
# Sync static site to S3 using alternate profile
aws s3 --profile qateam sync --delete public/ s3://example.com
```

**~/.aws/credentials**
```bash
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[qateam]
aws_access_key_id=DKDIOEOQOSFX7EXAMPLE
aws_secret_access_key=adIELweXUtnFEMIsKdksoEQKe?ebPYEXAMPLEKEY
```

**~/.aws/config**
```bash
[default]
region=us-west-1
output=json

[qateam]
region=us-east-1
output=json
```

# Resources
  * https://blog.gruntwork.io/authenticating-to-aws-with-the-credentials-file-d16c0fbcbf9e
