class ChangeDatatypeCafeLatLngOfMaps < ActiveRecord::Migration[5.1]
  def change
    change_column :maps, :cafe_lat_lng, :float, array:true
    change_column :maps, :center_lat_lng, :float, array:true
  end
end
