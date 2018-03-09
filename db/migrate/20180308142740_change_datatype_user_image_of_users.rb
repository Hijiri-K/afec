class ChangeDatatypeUserImageOfUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :image_name, :string, default: "user_image_default.jpg"
  end
end
