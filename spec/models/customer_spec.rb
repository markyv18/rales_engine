require 'rails_helper'

RSpec.describe Customer, type: :model do
  it 'Customer has a first and last name and creation/update values' do
    customer = create(:customer)

    expect(customer).to respond_to(:first_name)
    expect(customer).to respond_to(:last_name)
    expect(customer).to respond_to(:created_at)
    expect(customer).to respond_to(:updated_at)

  end
end
