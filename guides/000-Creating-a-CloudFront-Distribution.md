# Creating a CloudFront Distribution

A "distribution" is the collection of an origin location (your website) and edge locations. The content delivery network (CDN) makes clones of the origin content and places them at edge locations closer to the end user for faster delivery.

### Benefits of using CloudFront
  * GZIP'ed network transfer
  * AWS-managed security certificates don't expire every 90 days (like Let's Encrypt certificates)

## Creating a Distribution
 You can use an S3 bucket as the origin for your distribution. S3 buckets can host static content, which is easier to manage than administering servers (like Rackspace or Lightsail).
 1. Log into the AWS Management Console and choose CloudFront
 2. "Create Distribution" button > Web delivery method > "Get Started" button
 3. Origin Domain Name: DO NOT choose your S3 bucket from the dropdown list
 Put in the Static Website Hosting endpoint. The endpoint will "-website-" in its name. Ex: hodgkinhub.com.s3-website-us-west-1.amazonaws.com
 4. Origin ID: will automatically fill in if you pick your S3 bucket
 5. Enable HTTPS
 Viewer Protocol Policy: Redirect HTTP to HTTPS
 6. Set Minimum TTL to be 1 hour before CloudFront fetches from the origin Object Caching: Customize
 Minimum TTL: 3600
 7. Enable GZIP
 Compress Objects Automatically: Yes
 8. Price Class: "Use Only U.S., Canada and Europe"
 If the drug isn't available outside the U.S., then we should pick this lower price class
 9. Default Root Object: index.html
 If React Router can't handle loading "domain.com/index.html" without showing an error, then leave this value blank
 10. Click "Create Distribution" button
 Customizing Error Pages
 We want to respond to any 4xx responses from our S3 bucket with index.html and a 200 status code.. We are trying to avoid 4xx responses that may be blocked by certain corporate firewalls and proxies, which tend to block 4xx and 5xx responses.
 1. Click on the ID on the newly created distribution (origin should match your bucket) 2. "Error Pages" tab > "Create Custom Error Response" button
 a. HTTP Error Code: 403: Forbidden b. Customize Error Response: Yes
 Response Page Path: /index.html
 HTTP Response Code: "200 OK" (Not 403) c. Repeat steps "a" and "b" above for "404: Not Found"
 HTTP Response Code: "200 OK" (Not 404) d. Save settings with "Yes, Edit" button
 It may take up to 15 minutes for CloudFront to clone your content to all geographic regions. The status will be "Deployed" when it's done.
 Invalidating Old Content
              View the article about deleting all copies of the content and forcing the distribution to pull from the source bucket again.

               Deleting a Distribution
               1. Enable the checkbox for your distribution > "Disable" button > "Yes, Disable" > "Close" button (can take up to 15 minutes)
               2. After the status is "Deployed" instead of "In Progress", enable the checkbox for your distribution > "Delete" button > "Yes, Delete" >
               "Close" button
               Sources
               http://lofi.fi/deploying-gatsbyjs-to-amazon-aws/ https://aws.amazon.com/blogs/aws/new-gzip-compression-support-for-amazon-cloudfront/ https://aws.amazon.com/premiumsupport/knowledge-center/cloudfront-serve-static-website/ https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/HowToDeleteDistribution.html

