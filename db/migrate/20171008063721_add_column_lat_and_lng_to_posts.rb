class AddColumnLatAndLngToPosts < ActiveRecord::Migration[5.1]
  def change
      add_column :posts, :lat, :decimal
      add_column :posts, :lng, :decimal
  end
end
