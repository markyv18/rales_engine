FactoryGirl.define do
  factory :invoice do
    name "Dr Evil purchase"
    description "One FaFillion"
    status "shipped"
    customer
    merchant

    factory :invoice_with_transactions do
      transient do
        transaction_count 3
      end

      after(:create) do |invoice, evaluator|
        create_list(:transaction, evaluator.transaction_count, invoice: invoice)
      end
    end

    factory :invoice_with_items do
      transient do
        item_count 3
      end

      after(:create) do |invoice, evaluator|
        create_list(:invoice_item, evaluator.item_count, invoice: invoice)
      end
    end
  end
end
