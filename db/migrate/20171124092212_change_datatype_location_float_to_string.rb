class ChangeDatatypeLocationFloatToString < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :location, :text
  end
end
