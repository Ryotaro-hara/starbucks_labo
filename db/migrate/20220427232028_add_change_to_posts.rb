class AddChangeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :change, :integer, default: 0, null: false
  end
end
