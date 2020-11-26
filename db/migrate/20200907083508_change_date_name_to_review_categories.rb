class ChangeDateNameToReviewCategories < ActiveRecord::Migration[5.2]
  def change
    change_column :review_categories, :name, :string
  end
end
