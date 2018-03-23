class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :trade_with_id
      t.string :give_currency
      t.string :receive_currency
      t.float :usd_amount
      t.string :airports

      t.timestamps
    end
  end
end
