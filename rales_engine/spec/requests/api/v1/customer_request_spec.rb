require 'rails_helper'

describe "customers API" do
  it "sends a list of customers" do
    create_list(:customer, 5)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body)
    customer = customers.first

    expect(customers.count).to eq(5)
    expect(customer).to have_key("first_name")
  end

  it "returns a single customer based on id" do 
    customer_id = create(:customer).id

    get "/api/v1/customers/#{customer_id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(customer["id"]).to eq(customer_id)
  end
end
