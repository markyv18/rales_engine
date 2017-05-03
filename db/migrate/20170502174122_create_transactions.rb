class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string  :credit_card
      t.string  :result
      t.integer :invoice_id
    end
  end
end
