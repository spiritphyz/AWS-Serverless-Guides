# Add canonical tags to your pages
Every page of your site should have a `<link>` tag that represents the "official public link" of the page. The link should have the fully qualified domain. This canonical link will appear in search engine results and help the crawlers avoid treating URL variations as separate pages of duplicate content.
#### URL variations that shouldn't be indexed
  * http://www.example.com (links to the insecure HTTP protocol)
  * https://www.example.com/index.html
  * https://www.example.com/index.html?step=2

#### Example link tag for the canonical home page
```html
  <head>
    <link rel="canonical" href="https://www.example.com/" />
  </head>
```

---

# Set up path redirection for the base bucket
If you need redirection rules similar to Apache's `.htaccess` file, you need to translate those rules into XML conditions for S3. You can paste the new rules into the Static Website Hosting settings.
1. Go back to the [main bucket list](https://console.aws.amazon.com/s3/home), choose `example.com`
1. "Properties" tab > Static website hosting
1. "Use this bucket to host a website" > Redirection rules (optional):

Two example scenarios are given below. The first RoutingRule is based on protocol and domain (like `https://www.example.com/getting-here`).

The second RoutingRule is to redirect the old URL fragment of `Old%20Manual.pdf` to a new path of `new-manual`.

```xml
<RoutingRules>
  <RoutingRule>
    <Condition>
      <KeyPrefixEquals>driving-directions</KeyPrefixEquals>
    </Condition>
    <Redirect>
      <Protocol>https</Protocol>
      <HostName>www.example.com</HostName>
      <ReplaceKeyWith>assets/pdf/driving-directions.pdf</ReplaceKeyWith>
      <HttpRedirectCode>301</HttpRedirectCode>
    </Redirect>
  </RoutingRule>

  <RoutingRule>
    <Condition>
      <KeyPrefixEquals>Old%20Manual.pdf</KeyPrefixEquals>
    </Condition>
    <Redirect>
      <ReplaceKeyPrefixWith>new-manual</ReplaceKeyPrefixWith>
    </Redirect>
  </RoutingRule>
</RoutingRules>
```

Note that `<KeyPrefixEquals>` **cannot begin with a slash** (as is the usual pattern in  `.htaccess` files). The condition matches a S3 key and not a web path.

# Resources
  * https://moz.com/learn/seo/canonicalization
  * https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html#advanced-conditional-redirects
  * https://www.joshmcarthur.com/til/2018/09/04/configuring-s3-redirect-rules.html
