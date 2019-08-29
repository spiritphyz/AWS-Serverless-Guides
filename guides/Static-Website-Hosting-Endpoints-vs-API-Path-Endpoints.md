# Notes on Static Website Hosting links
For S3 buckets, the Static Website Hosting endpoint has a different URL than the API endpoint (the one that is listed for each S3 object). The SWH endpoint has a subdomain pattern similar to  **s3-website-region**, and the pattern is preceded by the bucket name.
  * **Static Website Hosting endpoint** (HTTP)
    * http://example.com.s3-website-us-west-1.amazonaws.com/
  * **API endpoint for individual S3 object** (HTTPS)
    * https://s3-us-west-1.amazonaws.com/example.com/index.html

Note that SWH endpoints are not secure! They can be secured by placing a CloudFront distribution in front of them. In a very confusing manner, the API endpoint for an individual S3 object has a secure URL even though simultaneously, the default SWH endpoint for the bucket is insecure.

