class AddColumnsToInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_items, :quantity, :integer
    add_column :invoice_items, :unit_price, :string
  end
end
