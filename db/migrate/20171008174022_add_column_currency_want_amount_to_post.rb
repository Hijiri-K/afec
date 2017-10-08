class AddColumnCurrencyWantAmountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :currency_want_amount, :float
  end
end
