class RemoveCenterLatLngFromMaps < ActiveRecord::Migration[5.1]
  def change
    remove_column :maps, :center_lat_lng, :float
  end
end
