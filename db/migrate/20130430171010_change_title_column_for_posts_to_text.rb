class ChangeTitleColumnForPostsToText < ActiveRecord::Migration
  def self.up
   change_column :posts, :title, :text
  end

  def self.down
   change_column :posts, :title, :string
  end
end
