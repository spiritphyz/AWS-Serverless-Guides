# Invalidating Old Data on CloudFront

A disadvantage to using a CDN is that you won't be able to see the newest changes easily. The edge copies won't expire for a long time, up to 24 hours. To check for newly published content, you can create an invalidation to force CloudFront to fetch from the origin and copy them to the edge locations, allowing visitors to see the new content in all geographic regions.

## Creating an invalidation to force a refresh from the origin
1. Log into the AWS Management Console and search for [ CloudFront ](https://console.aws.amazon.com/cloudfront/home?#)
2. Click on the distribution ID of your target domain name or origin bucket
3. Click on "Invalidations" tab, click on "Create Invalidation" button
4. For object paths, you can enter folders, files, or everything:
    * `/images/*`
    * `index.html`
    * `*`

Note that only the first 1,000 invalidation paths are free per month across ALL of our distributions. A path that has the `*` wildcard counts as one path even thought it may cause CloudFront to invalidate thousands of files.

It may take several minutes for the invalidation to finish as AWS has to process all files in all of the geographic zones that host your origin's content.

You might need to force your browser to ignore local copies and refetch by pressing Shift and clicking the Reload Button. Sometimes the local DNS routes may have stale content, too, so you may need to wait a few minutes for the content to appear.

## Making objects expire faster
Instead of making an invalidation, you can also choose to make the distribution's objects expire faster (shorter TTL, Time To Live). The distribution can override Cache Headers from the origin and always set a shorter TTL.

1. Log into the AWS Management Console and search for [ CloudFront ](https://console.aws.amazon.com/cloudfront/home?#)
2. Click on the distribution ID of your target domain name or origin bucket
3. Behaviors tab > Enable checkbox for "Default (*)" Path Pattern > Edit button > Object Caching: Customize
    * Default TTL: decrease this number
        * Units are in seconds, so 86400 / 3600sec = 24 hrs
    * Set the Minimum TTL to 3600
4. Save the settings by clicking on "Yes, Edit" button at bottom of page

## Invalidating a distribution on the command line
 You can use the [CLI to create an invalidation](./AWS-CLI-Cheatsheet.md#create-a-cloudfront-invalidation).

# Sources
  * https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html
  * https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Invalidation.html#PayingForInvalidation

