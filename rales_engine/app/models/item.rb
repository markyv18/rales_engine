class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.most_items(quantity)
    select("sum(invoice_items.quantity) as total_sold, items.id, items.name, items.description")
    .joins(:invoice_items).group("items.id").order("total_sold DESC").limit(quantity)
  end

  def self.best_day(id)
    # binding.pry
  end

end
