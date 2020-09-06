class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :review_category_id, null: false
      t.string :name, null: false
      t.text :content, null: false
      t.string :image_id
      t.float :rate

      t.timestamps
    end
  end
end
