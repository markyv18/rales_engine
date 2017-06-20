require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it 'Merchant has a name and creation/update values' do
    merchant = create(:merchant)

    expect(merchant).to respond_to(:name)
    expect(merchant).to respond_to(:created_at)
    expect(merchant).to respond_to(:updated_at)

  end
end
