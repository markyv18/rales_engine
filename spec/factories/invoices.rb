FactoryGirl.define do
  factory :invoice do
    status ["ordered", "paid", "shipped", "closed"].sample
    customer
    merchant
  end
end
