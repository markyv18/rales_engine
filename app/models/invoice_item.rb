class InvoiceItem < ApplicationRecord

  def self.random
    order("RANDOM()").first
  end

end
