class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :invoices, :name, :status
  end
end
