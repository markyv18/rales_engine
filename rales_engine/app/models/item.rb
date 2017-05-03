class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_items(quantity)
    .joins([invoices: :transactions]).where(transactions: {result: "success"}).group("items.id").order("sum(invoice_items.quantity) DESC").limit(1).name
    # binding.pry
  end
end
