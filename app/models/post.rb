class Post < ActiveRecord::Base
  belongs_to :source

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  def image_from_url(url)
    self.image = URI.parse(url)
  end
end
