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

  it "returns a single customer based on id" do
    customer_id = create(:customer).id

    get "/api/v1/customers/#{customer_id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:id]).to eq(customer_id)
  end

  it "can find a customer by their id" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    get "/api/v1/customers/find?id=#{customer1.id}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:id]).to eq(customer1.id)
    expect(customer[:id]).to_not eq(customer2.id)

  end

  it "can find a customer by their first_name" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer1.first_name}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:first_name]).to eq(customer1.first_name)
    expect(customer[:first_name]).to_not eq(customer2.first_name)

  end

  it "can find a customer by their last_name" do
    customer1 = create(:customer)
    customer2 = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer1.last_name}"

    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(customer[:last_name]).to eq(customer1.last_name)
    expect(customer[:last_name]).to_not eq(customer2.last_name)

  end

  it "can find a customer by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    customer1 = create(:customer, created_at: timestamp)
    customer2 = create(:customer)

    get "/api/v1/customers/find?created_at=#{customer1.created_at}"
    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/customers/find?created_at=#{timestamp}"
    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(customer[:id]).to eq(customer1.id)
    expect(customer[:id]).to_not eq(customer2.id)

  end

  it "can find a customer by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    customer1 = create(:customer, updated_at: timestamp)
    customer2 = create(:customer)

    get "/api/v1/customers/find?updated_at=#{customer1.updated_at}"
    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/customers/find?updated_at=#{timestamp}"
    customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(customer[:id]).to eq(customer1.id)
    expect(customer[:id]).to_not eq(customer2.id)

  end

end
