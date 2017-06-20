class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.random
    order("RANDOM()").first
  end

  def self.fav_customer(merchant_id)
    self.find_by_sql("SELECT customers.*
                      FROM merchants
                      INNER JOIN invoices
                      ON invoices.merchant_id = merchant_id
                      INNER JOIN customers
                      ON customers.id = invoices.customer_id
                      WHERE merchants.id = #{merchant_id}
                      GROUP BY customers.id
                      ORDER BY count(customers.id) DESC;").first

  end
end
