class CreateReviewCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :review_categories do |t|
      t.integer :name, null: false

      t.timestamps
    end
  end
end
