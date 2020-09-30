class ChangeColumToBlog < ActiveRecord::Migration[5.2]
  def change
  	def up
    change_column :blogs, :content, :text, null: false, limit: 4294967295
  end

  def down
    change_column :blogs, :content, :text, null: false
  end
  end
end
