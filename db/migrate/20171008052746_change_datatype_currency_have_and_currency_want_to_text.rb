class ChangeDatatypeCurrencyHaveAndCurrencyWantToText < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :currency_have, :text
    change_column :posts, :currency_want, :text
  end
end
