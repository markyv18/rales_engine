class Item < ApplicationRecord

  def self.random
    order("RANDOM()").first
  end

end
