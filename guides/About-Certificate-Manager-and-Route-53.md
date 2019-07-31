## AWS Certificate Manager
#### Managed certificate renewal
ACM creates free HTTPS certificates that are continuously renewed by Amazon. These managed renewals are more reliable than the Let's Encrypt certificates that need brittle cron jobs that tend to break at unfortunate times – like at the beginning of the new year when few people are working, or during silent cron job breakage when the server is misconfigured.

#### More secure site traffic, better SEO
A SSL-enabled site will encrypt all network transfers, preventing attackers from inspecting the traffic or modifying it while in transit. All browsers will show a prominent "Not Secure" label next to the website if no SSL certificate is installed. SSL-enabled sites also score higher in Google's search rankings.

## Route 53 DNS management
#### Mixed ownership: client controls domain, we control the DNS
A client can maintain control of a domain name. To manage that domain on AWS, we need the domain's nameserver records pointing to Route 53, giving us the ability to make all the necessary DNS records (A, CNAME, MX, etc.). CNAME records are required for verifying domains during certificate creation.

#### Requesting nameserver configuration
When a Record Set is made for a new Hosted Zone in Route 53, 4 NS records will be shown. For mixed domain ownership scenarios where the client owns the domain but we manage the domain's DNS, you can ask the client's IT team to change the nameservers in their DNS service provider (like GoDaddy) to point towards the 4 AWS nameservers listed in the Record Set.

When the domain's nameservers are set to Route 53's nameservers, we can then create the certificate and succesfully validate the domain (by making CNAME records in Route 53).

Continue to the [TLS certificate guide](./Creating-a-SSL-TLS-Certificate-for-a-Custom-Domain.md).