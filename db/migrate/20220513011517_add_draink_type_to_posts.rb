class AddDrainkTypeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :drink_type, :string
  end
end
