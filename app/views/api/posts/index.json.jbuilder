json.pagination do
  json.total_records @posts.size
  # TODO: Build this out further
  # json.total_count @posts.total_count
  # json.current_page @posts.current_page
  # json.total_pages @posts.total_pages
  # json.per_page @posts.count
end

json.entries @posts do |json, post|
  json.extract! post, :id, :original_url
  json.thumb_image_url post.image.url(:thumb)
  json.title post.title.downcase
end
