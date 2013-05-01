class Post < ActiveRecord::Base
  belongs_to :source

  has_attached_file :image, styles: { thumb: '340' }
end
