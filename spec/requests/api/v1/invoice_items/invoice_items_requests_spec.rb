require 'rails_helper'

describe "invoice_items API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 5)

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)
    invoice_item = invoice_items.first

    expect(invoice_items.count).to eq(5)
    expect(invoice_item[:quantity]).to be_a Integer
    expect(invoice_item[:unit_price]).to be_a Integer
  end

  it "returns a single invoice_item based on id" do
    invoice_item_id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{invoice_item_id}"

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:id]).to eq(invoice_item_id)
  end

  it "can find a invoice_item by their id" do
    a = create_list(:invoice_item, 5)
    invoice_item1 = a.first
    invoice_item2 = a[1]

    get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:id]).to eq(invoice_item1.id)
    expect(invoice_item[:id]).to_not eq(invoice_item2.id)

  end

  it "can find a invoice_item by quantity" do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)
    get "/api/v1/invoice_items/find?quantity=#{invoice_item1.quantity}"

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:quantity]).to eq(10)

  end

  it "can find a invoice_item by unit_price" do
    invoice_item1 = create(:invoice_item)
    invoice_item2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item1.unit_price}"

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:unit_price]).to eq(100000)

  end

  it "can find a invoice_item by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    invoice_item1 = create(:invoice_item, created_at: timestamp)
    invoice_item2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?created_at=#{invoice_item1.created_at}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/invoice_items/find?created_at=#{timestamp}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item[:id]).to eq(invoice_item1.id)
    expect(invoice_item[:id]).to_not eq(invoice_item2.id)

  end

  it "can find a invoice_item by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    invoice_item1 = create(:invoice_item, updated_at: timestamp)
    invoice_item2 = create(:invoice_item)

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item1.updated_at}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/invoice_items/find?updated_at=#{timestamp}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item[:id]).to eq(invoice_item1.id)
    expect(invoice_item[:id]).to_not eq(invoice_item2.id)

  end

  it "can find all invoice_items by id" do
    list = create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?id=#{list.last.id}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item.first[:id]).to eq(list.last.id)
  end

  it "can find all invoice_items by quantity" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/find_all?quantity=10"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item.count).to eq(3)
  end

  it "can find all invoice_items by unit_price" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/find_all?unit_price=100000"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item.count).to eq(3)
  end


  it "can find all invoice_items by created_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:invoice_item, 3, created_at: timestamp)

    get "/api/v1/invoice_items/find_all?created_at=#{timestamp}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item.count).to eq(3)
  end

  it "can find all invoice_items by updated_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:invoice_item, 5)
    create_list(:invoice_item, 3, updated_at: timestamp)

    get "/api/v1/invoice_items/find_all?updated_at=#{timestamp}"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item.count).to eq(3)
  end

  it "can return a random invoice_item" do
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/random"
    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice_item[:id]).to be_a(Integer)
    expect(invoice_item[:quantity]).to be_a(Integer)
    expect(invoice_item[:unit_price]).to be_a(Integer)
  end


end
