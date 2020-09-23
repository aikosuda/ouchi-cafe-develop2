class AddReviewIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :review_id, :integer
  end
end
