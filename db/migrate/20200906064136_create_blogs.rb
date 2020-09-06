class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :image_id

      t.timestamps
    end
  end
end
