  FactoryGirl.define do
    factory :item do
      name {Faker::Name.name}
      description {Faker::Name.last_name}
    end
  end
