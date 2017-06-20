class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.fav_merch(customer_id)
    self.find_by_sql("SELECT merchants.*
                      FROM customers
                      INNER JOIN invoices
                      ON invoices.customer_id = customer_id
                      INNER JOIN merchants
                      ON merchants.id = invoices.merchant_id
                      WHERE customers.id = #{customer_id}
                      GROUP BY merchants.id
                      ORDER BY count(merchants.id) DESC;").first
                      #shoot me now
  end

end
