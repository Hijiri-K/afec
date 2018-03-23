class AddColumnSecurityareaToMap < ActiveRecord::Migration[5.1]
  def change
    add_column :maps, :security_area, :string
  end
end
