# Creating SSL/TLS Certificates for Custom Domains

## AWS Certificate Manager
#### Managed certificate renewal
ACM creates free HTTPS certificates that are continuously renewed by Amazon. These managed renewals are more reliable than the free Let's Encrypt certificates that need brittle cron jobs that tend to break at unfortunate times – like at the beginning of the new year when few people are working, or during silent cron job breakage when the server is misconfigured.

#### More secure site traffic, better SEO
A SSL-enabled site will encrypt all network transfers, preventing attackers from inspecting the traffic or modifying it while in transit. All browsers will show a prominent "Not Secure" label next to the website if no SSL certificate is installed. SSL-enabled sites also score higher in Google's search rankings.

## Route 53 DNS management
#### Mixed ownership: client controls domain, we control the DNS
A client can maintain control of a domain name. To manage that domain on AWS, we need the domain's nameserver records pointing to Route 53, giving us the ability to make all other DNS records (A, CNAME, MX, etc.). CNAME records are required for verifying domains during certificate creation.

#### Requesting nameserver configuration
When a Record Set is made for a new Hosted Zone in Route 53, 4 NS records will be shown. For mixed domain ownership scenarios where the client owns the domain but we manage the domain's DNS, you can ask the client's IT team to change the nameservers in their DNS service provider (like GoDaddy) to point towards the 4 AWS nameservers listed in the Record Set. (Examples will be shown below.)

When the domain's nameservers are set to Route 53's nameservers, we can then create the certificate and succesfully validate the domain (through CNAME records inside Route 53).

## Creating a SSL certificate tied to a domain name
Note: certificate requests time out after 72 hours if they can't be validated.

1. Log into the AWS Management Console, search for Certificate Manager 2. "Request a certificate" button > "Request a public certificate" button >
Domain name: www.example.com 3. "Add another name to this certificate" button >
example.com
4. Choose DNS validation (we can modify the DNS configuration in AWS) Status for both domains will be "Pending validation"
5. "Review" button > "Confirm and request" button > "Continue" button
If all DNS settings are managed by Route 53 (and not a custom domain manager like GoDaddy), you can click "Create record in Route 53" button for both domains
You should see a "Success" message for both domains
It may take up to 30 minutes for the changes to propagate, and for AWS to validate the domain.
The final status for each domain should be "Issued"
Use the SSL certificate in CloudFront
1. Log into the AWS Management Console, search for CloudFront
2. Click on the distribution ID that matches your origin bucket > Click "Edit" button > SSL Certificate > Custom SSL Certification
In the auto-populated dropdown list, pick the certificate made through Certificate Manager 3. Alternate Domain Names (CNAMEs) > add domain names below and separate them by new lines
www.example.com
4. "Yes, Edit" button
5. Change the default cache behavior
"Behaviors" tab > Select checkbox for "Default (*)" > "Edit" button > Viewer Protocol Policy > Redirect HTTP to HTTPS "Yes, Edit" button
It will take some time for your changes to propagate across all geographic regions, around 15 minutes.
Set "A Records" with aliases to CloudFront
Before making the changes below, make sure the CloudFront distribution has a status of "Deployed".
1. Log into the AWS Management Console, search for Route 53
2. "Hosted zones" on left sidebar > www.example.com. > Enable checkbox for "www.example.com.", Type A > change settings on
right sidebar
Type: A - IPv4 address
Alias: Yes
Alias Target: Dropdown list should show your CloudFront distribution, so pick it "Save Record Set" button
3. Repeat Step 2 with with the A Record for the bare domain: example.com
To Do: rewrite this section for creating a Redirect S3 Bucket and Redirect CloudFront, then connecting "A" Record to Redirect CloudFront
4.

4. Check website in browser
Make sure "http:/www./example.com" redirects to "https://www.example.com"
Resources
https://docs.aws.amazon.com/acm/latest/userguide/managed-renewal.html https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate-dns.html https://medium.com/@brodartec/hosting-a-static-site-with-https-enabled-using-aws-s3-cloudfront-and-godaddy-826dae41fdc6

