class AddGroupToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :group, :string
  end
end
