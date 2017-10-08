class AddCurrencyHaveAndCurrencyHaveAmountCurrencyWantAndLocationToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :currency_have, :text
    add_column :posts, :currency_have_amount, :float
    add_column :posts, :currency_want, :text
    add_column :posts, :location, :float

  end
end
