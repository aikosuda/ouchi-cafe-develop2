class ChangeColumnToBlogs < ActiveRecord::Migration[5.2]
  def change
    change_column :blogs, :content, :text, null: false, :limit => 4294967295
  end
end
