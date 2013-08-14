require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

require 'snooby'
require 'tumblr_client'
require 'john_stamos'

namespace :impel do
  desc "query reddit for content"
  task poll_reddit: :environment do
    motivations = []
    subreddits = %w{GetMotivated QuotesPorn quoteporn MotivationalPics MotivateMe gotmotivated motivation Motivational}

    reddit = Snooby::Client.new
    subreddits.each{ |sub| motivations += reddit.r(sub).posts }

    motivations = motivations.select{ |motivation| image?(motivation.url) }
    motivations.each do |motivation|
      begin
        post = Post.where(original_url: "http://reddit.com" + motivation.permalink).first_or_create do |m|
          m.image = image_from_url(motivation.url)
          m.title = motivation.title
          m.source = Source.where(title: "reddit").first_or_create
          m.author_title = motivation.author
          m.author_url = "http://reddit.com/u/" + motivation.author
          m.raw_blob = motivation.to_yaml
        end
      rescue OpenURI::HTTPError => ex
        puts "What the fudge!?"
        puts ex
      end

    end
  end

  desc "query tumblr for content"
  task poll_tumblr: :environment do
    Tumblr.configure do |config|
      config.consumer_key = Figaro.env.tumblr_consumer_key
      config.consumer_secret = Figaro.env.tumblr_consumer_secret
      config.oauth_token = Figaro.env.tumblr_oauth_token
      config.oauth_token_secret = Figaro.env.tumblr_oauth_token_secret
    end

    motivations = []
    tags = %w{motivation-quote inspirational-quote inspirational-quotes famous-quotes wisdom}

    tumblr = Tumblr::Client.new
    tags.each{ |tag| motivations += tumblr.tagged(tag) }

    motivations = motivations.select{ |motivation| motivation["type"] == "photo" && motivation["note_count"] > 3}
    motivations.each do |motivation|
      begin
        post = Post.where(original_url: motivation["post_url"]).first_or_create do |m|
          m.image = image_from_url(motivation["photos"][0]["original_size"]["url"])
          m.title = motivation["caption"]
          m.source = Source.where(title: "tumblr").first_or_create
          m.author_title = motivation["blog_name"]
          m.author_url = "http://" + motivation["blog_name"] + ".tumblr.com"
          m.raw_blob = motivation.to_yaml
        end
      rescue OpenURI::HTTPError => ex
        puts "Mother Flower!"
        puts ex
      end
    end
  end

  desc "query pinterest for content"
  task poll_pinterest: :environment do

    pins = []
    search_params = %w{motivation-quote inspirational-quote inspirational-quotes words-to-live-by}

    pinterest_client = JohnStamos::Client.new(proxy: Figaro.env.proxy_address)

    search_params.each do |param|
      pins += pinterest_client.search_pins(param, limit: 10)
    end

    # If results suck, we could filter on repins or likes... or repins AND likes!
    pins.select!{ |pin| pin.like_count.to_i > 10 && !pin.video? }

    pins.each do |pin|
      begin
        post = Post.where(original_url: pin.url).first_or_create do |p|
          p.title = pin.description
          p.source = Source.where(title: "pinterest").first_or_create
          p.author_title = pin.pinner.full_name
          p.author_url = pin.pinner.url
          p.image = image_from_url(pin.image)
          p.raw_blob = pin.to_yaml
        end
      rescue OpenURI::HTTPError => ex
        puts "Son of a Biscuit!"
        puts ex
      end
    end
  end


  def image_from_url(url)
    URI.parse(url)
  end

end
