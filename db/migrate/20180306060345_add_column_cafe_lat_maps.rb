class AddColumnCafeLatMaps < ActiveRecord::Migration[5.1]
  def change
    remove_column :maps, :cafe_lat_lng, :float
    add_column :maps, :cafe_lat, :float
    add_column :maps, :cafe_lng, :float
    add_column :maps, :center_lat, :float
    add_column :maps, :center_lng, :float
  end
end
