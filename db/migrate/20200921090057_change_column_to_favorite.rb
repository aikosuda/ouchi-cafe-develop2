class ChangeColumnToFavorite < ActiveRecord::Migration[5.2]
  def up
    change_column :favorites, :blog_id, :integer, null: true
  end

  def down
    change_column :favorites, :blog_id, :integer, null: false
  end
end
