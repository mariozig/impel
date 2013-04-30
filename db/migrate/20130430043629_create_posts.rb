class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :image_url
      t.string :title
      t.integer :source_id
      t.string :title
      t.string :original_url
      t.string :author_title
      t.string :author_url

      t.timestamps
    end
  end
end
