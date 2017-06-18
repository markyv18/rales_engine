FactoryGirl.define do
  factory :invoice do
    name {Faker::Name.name}
    description {Faker::Name.last_name}
  end
end
