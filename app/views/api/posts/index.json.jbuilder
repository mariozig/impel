json.array!(@posts) do |post|
  json.extract! post, :id, :original_url
  json.thumb_image_url post.image.url(:thumb)
  json.title post.title.downcase
end