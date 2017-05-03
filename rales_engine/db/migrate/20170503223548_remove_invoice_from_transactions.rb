class RemoveInvoiceFromTransactions < ActiveRecord::Migration[5.0]
  def change
    remove_column :transactions, :invoice_id
  end
end
