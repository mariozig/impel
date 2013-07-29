# Impel 

The code that powers [impel.io](http://impel.io) -- a website that finds and reposts inspirational / motivational images from a number of different sources.

## About

[impel.io](http://impel.io) looks at a number of different source websites for motivational images, scrapes the post information, uploads the image to AWS and finally reposts it to Impel. Scraping is controlled by a handful of rake tasks.

Current sources are: 

* Reddit via a bunch of inspiring / motivational subreddits
* Tumblr via specific tags
* Pinterest via a number of different searches that are scraped

## A Note About Pinterest and Heroku

As of now, Pinterest does not offer a public API so the results must be scraped.  In addition to that, Pinterest also blocks requests from IP addresses that original from AWS's range of IPs.

What does this mean? It means that if you use Heroku as a host you're gonna have a bad time. Heroku is built on top of AWS and as a result if you want to get Pinterest results while being on Heroku you will need to proxy the requests.

The pinterest rake task monkey patches the Pinteresting gem (my fork of it) to account for this so you don't have to do anything, but it's a good thing to know about.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request