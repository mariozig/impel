class AddRawBlobToPost < ActiveRecord::Migration
  def change
    add_column :posts, :raw_blob, :text
  end
end
