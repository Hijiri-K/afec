class AddColumnOfferToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :offer, :integer
  end
end
