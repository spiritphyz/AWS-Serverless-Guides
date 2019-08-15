# Use a fully qualified domain for the canonical site
  * Apex domain: `example.com`
  * Fully qualified domain: `www.example.com`

It's tempting to set up [DNS](http://www.steves-internet-guide.com/dns-guide-beginners/) to use the apex domain of `example.com`. This seems to create a simpler canonical base for all of your hyperlinks. An apex domain is created with a CNAME record. However, new DNS records can't be made from CNAME records.

For example, if you want to host email services on the apex domain, you won't be able to create the necessary MX records from a CNAME record.

It's better to start off all your hyperlinks with `www.example.com` (or any other subdomain like `app.example.com`). By using the `www` subdomain, you have more flexibility in creating additional DNS records for common situations like:
  * MX records for email services
  * TXT records for domain validation
  * Load balancing options to redirect traffic from subdomains. The "CNAME and A Name" combination records are tied to a raw IP address that can't be load balanced.

# Avoiding duplicate content
We will use the full domain `www.example.com` for the base bucket and create a second bucket to redirect the apex domain to the full domain. This configuration avoids content duplication, which is heavily penalized by search engines.

# Set up the base bucket
Replace `example.com` below with the domain of your website.
1. Log into the management console, [search for S3](https://console.aws.amazon.com/s3/home)
1. "Create Bucket" button
    * Bucket name: `example.com`
    * Region: `US West (N. California)`

# Set up the redirect bucket
# Add Canonical tags to the <head> section of pages
# Set up rewrite rules for the base bucket

# Resources
  * https://www.netlify.com/blog/2017/02/28/to-www-or-not-www/
  * https://moz.com/learn/seo/canonicalization
