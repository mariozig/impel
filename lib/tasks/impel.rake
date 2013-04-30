require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

require 'snooby'
require 'tumblr_client'

namespace :impel do
  desc "query reddit's /r/GetMotivated for content"
  task poll_reddit: :environment do
    motivations = []
    subreddits = %w{GetMotivated QuotesPorn MotivationalPics MotivateMe gotmotivated}

    reddit = Snooby::Client.new
    subreddits.each{ |sub| motivations += reddit.r(sub).posts }

    motivations = motivations.select{ |motivation| image?(motivation.url) }
    motivations.each do |motivation|
      post = Post.where(original_url: "http://reddit.com" + motivation.permalink).first_or_create do |m|
        m.image = Post.image_from_url(motivation.url)
        m.title = motivation.title
        m.source = Source.where(title: "reddit").first_or_create
        m.author_title = motivation.author
        m.author_url = "http://reddit.com/u/" + motivation.author
        m.raw_blob = motivation.to_yaml
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
    tags = %w{life-quote motivation-quote inspirational-quote}

    tumblr = Tumblr::Client.new
    tags.each{ |tag| motivations += tumblr.tagged(tag) }

    motivations = motivations.select{ |motivation| motivation["type"] == "photo" && motivation["note_count"] > 3}
    motivations.each do |motivation|
      post = Post.where(original_url: motivation["post_url"]).first_or_create do |m|
        m.image = Post.image_from_url(motivation["photos"][0]["original_size"]["url"])
        m.title = motivation["caption"]
        m.source = Source.where(title: "tumblr").first_or_create
        m.author_title = motivation["blog_name"]
        m.author_url = "http://" + motivation["blog_name"] + ".tumblr.com"
        m.raw_blob = motivation.to_yaml
      end
    end
  end

end