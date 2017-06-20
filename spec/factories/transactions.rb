require 'faker'

FactoryGirl.define do
  factory :transaction do
    credit_card { Faker::Business.credit_card_number }
    result ["success", "denied", "pending"].sample
    invoice
  end
end
