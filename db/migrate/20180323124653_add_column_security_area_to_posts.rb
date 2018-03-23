class AddColumnSecurityAreaToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :security_area, :string
  end
end
