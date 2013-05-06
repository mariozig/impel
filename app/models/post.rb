class Post < ActiveRecord::Base
  belongs_to :source

  has_attached_file :image, styles: { thumb: '340' }

  def self.a_page(page_number=nil)
    Post.order("created_at DESC").page(page_number).per(25)
  end
end