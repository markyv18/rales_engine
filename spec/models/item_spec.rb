require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'Item has a name, description, unit_price, merchant_id and creation/update values' do
    item = create(:item)

    expect(item).to respond_to(:name)
    expect(item).to respond_to(:description)
    expect(item).to respond_to(:unit_price)
    expect(item).to respond_to(:merchant_id)
    expect(item).to respond_to(:created_at)
    expect(item).to respond_to(:updated_at)

  end
end
