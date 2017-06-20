require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it 'Invoice has a status, merchant_id, customer_id, created_at, updated_at' do
    invoice1 = create(:invoice)
    expect(invoice1).to respond_to(:status)
    expect(invoice1).to respond_to(:customer_id)
    expect(invoice1).to respond_to(:merchant_id)
    expect(invoice1).to respond_to(:created_at)
    expect(invoice1).to respond_to(:updated_at)
  end
end
