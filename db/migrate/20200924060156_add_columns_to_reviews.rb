class AddColumnsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :price, :integer
    add_column :reviews, :manufacturer, :string
  end
end
