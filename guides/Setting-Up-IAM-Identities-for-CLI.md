# Using AWS CLI with stored credentials
Store your AWS credentials on your local machine for the CLI tools to authenticate to your company's AWS resources. Group and individual privileges are managed in Identity and Access Management.

## Create the group
For the purposes of this guide, "tribedev" will represent the group for individual developers that has shared privileges. This group will have administrative policies to manage S3 and CloudFront.
1. FIXME

## Create a user with limited admin privileges
Each AWS user on your team can be added to "tribedev".

1. Log into the management console, [search for IAM](https://console.aws.amazon.com/iam/home?region=us-west-2#/home)

2. Click on Users > "Add User" button
    * User name: fname-lname-role
    * Access type: Programmatic access
    * "Next: Permissions" button

3. "Add user to group" button > "tribedev" checkbox > "Next: Tags" button > "Next: Review" button > "Create user" button

4. Save your "Access key ID" and "Secret access key", it will only be shown once!

## Setting up stored credentials with CLI
