FactoryGirl.define do
  factory :invoice_item do
    quantity 10
    unit_price 100000
    item
    invoice 
  end
end
