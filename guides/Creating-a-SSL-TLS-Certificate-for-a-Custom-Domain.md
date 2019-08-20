## Create a certificate tied to a custom domain
Note: certificate requests time out after 72 hours if they can't be validated.

1. In the AWS Management Console, search for [ Certificate Manager ](https://console.aws.amazon.com/acm/home?region=us-east-1#/)
2. "Request a certificate" button > "Request a public certificate" button
    * Domain name: [www.example.com]()
3. "Add another name to this certificate" button >
    * Domain name: [example.com]()
4. Choose DNS validation (we can modify the DNS configuration in AWS)
    * Status for both domains will be "Pending validation"
5. "Review" button > "Confirm and request" button > "Continue" button
    * If all DNS settings are managed by Route 53 (and not a custom domain manager like GoDaddy), you can click "Create record in Route 53" button for both domains
    * You should see a "Success" message for both domains
    * It may take up to 30 minutes for the changes to propagate and for AWS to validate the domain
    * The final status for each domain should be "Issued"

## Use the certificate in CloudFront
Certificates with custom domains can only be used with CloudFront distributions, not with S3 buckets.

The configuration below will follow the [recommended approach](./Setting-Up-S3-for-Domain-Redirects.md#introduction) of having a core bucket be the destination for the full domain `www.example.com`. Also, a redirect bucket will handle redirecting the apex domain `example.com` to the contents in the core bucket. Two CloudFront distributions sit in front of both buckets for CDN functionality and will be used as the targets for the DNS records.

### Use the certificate for the full domain
1. In the AWS Management Console, search for [ CloudFront ](https://console.aws.amazon.com/cloudfront/home?#)
2. Click on the distribution ID that matches your **base** bucket > "Edit" button > SSL Certificate > Custom SSL Certification
    * In the auto-populated dropdown list, pick the certificate made through Certificate Manager
3. Alternate Domain Names (CNAMEs) > add domain names below and separate them by new lines
    * [www.example.com]()
4. "Yes, Edit" button
5. Change the default cache behavior
    * "Behaviors" tab > Select checkbox for "Default (*)" > "Edit" button > Viewer Protocol Policy
    * Leave this as "**HTTP and HTTPS**" so we let users go directly to the HTTPS version and not produce an extra redirect
    * "Yes, Edit" button

### Use the certificate for the apex domain
1. Go back to the main [CloudFront](https://console.aws.amazon.com/cloudfront/home?#) page
2. Click on the distribution ID that matches your **redirect** bucket > "Edit" button > SSL Certificate > Custom SSL Certification
    * In the auto-populated dropdown list, pick the certificate made through Certificate Manager
3. Alternate Domain Names (CNAMEs) > add domain names below and separate them by new lines
    * [example.com]()
4. "Yes, Edit" button
5. Change the default cache behavior
    * "Behaviors" tab > Select checkbox for "Default (*)" > "Edit" button > Viewer Protocol Policy
    * **Redirect HTTP to HTTPS**
    * "Yes, Edit" button

It will take some time for your changes to propagate across all geographic regions, around 15 minutes.

## Set DNS records with aliases to CloudFront
Before making the changes below, make sure the CloudFront distributions has a status of "Deployed".

The Hosted Zone of `example.com.` was automatically created by AWS during the creation of the [TLS certificate](./Creating-a-SSL-TLS-Certificate-for-a-Custom-Domain.md). The Hosted Zone contains DNS records for both the `www.example.com` and `example.com` domains.

### Full domain records
1. Log into the AWS Management Console, search for [Route 53](https://console.aws.amazon.com/route53/home?#)
1. "Hosted zones" on left sidebar > [example.com.]() > "Create Record Set" button > change settings on right sidebar
    * Name: `www`.adcetrispro.com.
    * Type: A - IPv4 address
    * Alias: Yes
    * Alias Target: Dropdown list should show your CloudFront distribution for the full domain, so pick it
    * "Save Record Set" button
1. "Create Record Set" button > change settings on right sidebar
    * Name: `www`.adcetrispro.com.
    * Type: AAAA - IPv6 address
    * Alias: Yes
    * Alias Target: Dropdown list should show your CloudFront distribution for the full domain, so pick it

### Apex domain records
1. Go back to the main [Route 53](https://console.aws.amazon.com/route53/home?#) page
1. "Hosted zones" on left sidebar > [example.com.]() > "Create Record Set" button > change settings on right sidebar
right sidebar
    * Name: adcetrispro.com. (leave subdomain as blank)
    * Type: A - IPv4 address
    * Alias: Yes
    * Alias Target: Dropdown list should show your CloudFront distribution for the apex domain, so pick it
    * "Save Record Set" button
1. "Create Record Set" button > change settings on right sidebar
    * Name: adcetrispro.com. (leave subdomain as blank)
    * Type: AAAA - IPv6 address
    * Alias: Yes
    * Alias Target: Dropdown list should show your CloudFront distribution for the full domain, so pick it

## Check domains in browser
Make sure the the insecure domain "http://www.example.com" redirects to "[**https**://www.example.com](https://www.example.com)". It may take some time for the DNS changes to be seen by your ISP and local company network.

# Resources
  * https://docs.aws.amazon.com/acm/latest/userguide/managed-renewal.html
  * https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-dns.html
  * https://medium.com/@brodartec/hosting-a-static-site-with-https-enabled-using-aws-s3-cloudfront-and-godaddy-826dae41fdc6

