class CreateMaps < ActiveRecord::Migration[5.1]
  def change
    create_table :maps do |t|
      t.string :airports
      t.string :terminals
      t.string :floor_maps
      t.float :cafe_lat_lng
      t.float :center_lat_lng

      t.timestamps
    end
  end
end
