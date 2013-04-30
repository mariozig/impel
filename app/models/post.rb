class Post < ActiveRecord::Base
  belongs_to :source

  has_attached_file :image, styles: {
    thumb: '340'
  }
  attr_accessor :image_file_name

  def image_from_url(url)
    self.image = URI.parse(url)
  end
end
