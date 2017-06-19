class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def self.random
    order("RANDOM()").first
  end

end
