require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

require 'snooby'

namespace :impel do
  desc "query reddit's /r/GetMotivated for content"
  task poll_reddit: :environment do
    reddit = Snooby::Client.new
    motivations = reddit.r('GetMotivated').posts
    motivations = motivations.select{ |motivation| image?(motivation.url) }
    motivations.each do |motivation|
      post = Post.where(original_url: motivation.permalink).first_or_create do |m|
        m.image_url = motivation.url
        m.title = motivation.title
        m.source = Source.where(title: "reddit").first_or_create
        m.author_title = motivation.author
        m.author_url = "http://www.reddit.com/u/" + motivation.author
        m.raw_blob = motivation.to_yaml
      end
    end
  end

end