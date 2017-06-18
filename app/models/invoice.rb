class Invoice < ApplicationRecord

  def self.random
    order("RANDOM()").first
  end

end
