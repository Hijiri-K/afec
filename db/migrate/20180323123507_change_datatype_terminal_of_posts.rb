class ChangeDatatypeTerminalOfPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :terminal, :string
  end
end
