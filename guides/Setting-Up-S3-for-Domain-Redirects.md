# Use a fully qualified domain for the canonical site
  * Apex domain: `example.com`
  * Fully qualified domain: `www.example.com`

It's tempting to set up DNS to use the bare apex domain of `example.com`. It seems to create a simpler canonical base for all of your hyperlinks. This apex domain is created with a CNAME record. However, new DNS records can't be made from CNAME records.

For example, if you want to host email services on the bare domain, you can't create additional MX records from a CNAME record.

It's better to start off all your hyperlinks with `www.example.com` (or any other subdomain `app.example.com`). By using the `www` subdomain, you have more flexibility in creating additional DNS records for common situations like:
  * MX records for email services
  * TXT records for domain validation
  * Traffic redirection can occur on subdomains, but "CNAME and A Name" combination records are tied to a raw IP address that can't be load balanced

We will use the full domain `www.example.com` for the base bucket and create a second bucket to redirect the apex domain to the full domain.


# Resources
  * https://www.netlify.com/blog/2017/02/28/to-www-or-not-www/
