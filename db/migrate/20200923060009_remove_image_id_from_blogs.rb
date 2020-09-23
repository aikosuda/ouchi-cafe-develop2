class RemoveImageIdFromBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :image_id, :string
  end
end
