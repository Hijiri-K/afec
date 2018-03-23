class AddColumnMapRotationToMaps < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :rotations, :float
  end
end
