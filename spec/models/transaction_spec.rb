require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'Transaction has a CC#, result, invoice_id and creation/update values' do
    transaction = create(:transaction)

    expect(transaction).to respond_to(:credit_card)
    expect(transaction).to respond_to(:result)
    expect(transaction).to respond_to(:created_at)
    expect(transaction).to respond_to(:updated_at)
    expect(transaction).to respond_to(:invoice_id)

  end
end
