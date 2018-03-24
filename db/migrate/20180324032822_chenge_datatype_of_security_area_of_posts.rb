class ChengeDatatypeOfSecurityAreaOfPosts < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :security_area, :string, default: "OUT"
  end
end
