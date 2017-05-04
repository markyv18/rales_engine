require 'rails_helper'

describe "customers API" do
  it "sends a list of customers" do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body, symbolize_names: true)
    customer = customers.first

    expect(customers.count).to eq(5)
    expect(customer[:first_name]).to be_a String
    expect(customer[:last_name]).to be_a String
    expect(customer).to have_key(:first_name)
    expect(customer).to have_key(:last_name)
  end

end
