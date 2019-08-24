# Sections in this guide
  - [ ] [Introduction to CloudFront](./Creating-CloudFront-Distributions.md#introduction-to-cloudfront)
  - [ ] [Create a distribution for the origin bucket](./Creating-CloudFront-Distributions.md#create-a-distribution-for-the-origin-bucket)
  - [ ] [Customizing error pages](./Creating-CloudFront-Distributions.md#customizing-error-pages)
  - [ ] [Invalidating old content](./Creating-CloudFront-Distributions.md#invalidating-old-content)
  - [ ] [Deleting a distribution](./Creating-CloudFront-Distributions.md#deleting-a-distribution)
  - [ ] [Resources](./Creating-CloudFront-Distributions.md#resources)

---

## Introduction to CloudFront
### Distributions
A "distribution" is the collection of an origin location (your website) and edge locations. The content delivery network (CDN) makes clones of the origin content and places them at edge locations closer to the end user for faster delivery.

### Origin bucket
We will use a S3 bucket as the origin location for our content. S3 buckets can host static content, which has more cost, maintenance, and performance benefits than administering live servers. The distribution in front of this bucket will redirect insecure links to secure ones.

### Standard behaviors
We will set up typical features for faster content delivery and standardize the domain behavior for search engine indexing:
  * Enable GZIP for network transfers
  * Make the apex domain `example.com` redirect to the fully qualified domain `www.example.com`
  * Redirect the insecure protocol `http://example.com` to the secure `https://www.example.com`

---

## Create a distribution for the origin bucket
1. Log into the AWS Management Console and search for [CloudFront](https://console.aws.amazon.com/cloudfront/home?#)
1. "Create Distribution" button > Web delivery method > "Get Started" button
1. Origin Domain Name: **DO NOT** choose your S3 bucket from the dropdown list
    * Put in the [Static Website Hosting](./AWS-CLI-Cheatsheet.md#notes-on-static-website-hosting-links) endpoint.
    * The endpoint will have `-website-` in its name, like:
      * `example.com.s3-website-us-west-1.amazonaws.com`
1. Origin ID: will automatically fill in if you pick your S3 bucket
1. Enable HTTPS
    * Viewer Protocol Policy: Redirect HTTP to HTTPS
1. Set Minimum TTL to be 1 hour before CloudFront fetches from the origin
    * Object Caching: Customize
    * Minimum TTL: 3600
1. Enable GZIP
    * Compress Objects Automatically: Yes
1. Price Class: "Use Only U.S., Canada and Europe"
    * If your servics aren't available outside the U.S., then you should pick this lower price class
1. Default Root Object: `index.html`
    * If React Router can't handle loading `domain.com/index.html` without showing an error, then leave this value blank
1. Click "Create Distribution" button

## Customizing error pages
One strategy for a simpler website is to redirect 404 and 500 errors to the main index page. This may not be desirable if you are trying to use analytics to find broken links.

In this simpler scenario, we want to respond to broken links with a redirect to `index.html` and a 200 status code. We are trying to avoid 4xx responses that may be blocked by corporate firewalls and proxies, which tend to block 4xx and 5xx responses.

1. Click on the ID on the newly created distribution (origin should match your bucket)
2. "Error Pages" tab > "Create Custom Error Response" button
    * HTTP Error Code: 403: Forbidden
    * Customize Error Response: Yes
      * Response Page Path: /index.html
      * HTTP Response Code: "200 OK" (Not 403)
    * Repeat steps "a" and "b" above for "404: Not Found"
      * HTTP Response Code: "200 OK" (Not 404)
    * Save settings with "Yes, Edit" button

 It may take up to 15 minutes for CloudFront to clone your content to all geographic regions. The status will be "Deployed" when it's done.

## Invalidating old content
[View the guide](./Invalidating-Old-Data-on-Cloudfront.md) about deleting all copies of the content and forcing the distribution to pull from the source bucket again.

## Deleting a distribution
1. Enable the checkbox for your distribution > "Disable" button > "Yes, Disable" > "Close" button (can take up to 15 minutes)
2. After the status is "Deployed" instead of "In Progress", enable the checkbox for your distribution > "Delete" button > "Yes, Delete" > "Close" button

# Resources
  * http://lofi.fi/deploying-gatsbyjs-to-amazon-aws/
  * https://aws.amazon.com/blogs/aws/new-gzip-compression-support-for-amazon-cloudfront/
  * https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serve-static-website/
  * https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/HowToDeleteDistribution.html

