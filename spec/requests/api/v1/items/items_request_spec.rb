require 'rails_helper'

describe "items API" do
  it "sends a list of items" do
    create_list(:item, 5)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)
    item = items.first

    expect(items.count).to eq(5)
    expect(item[:name]).to be_a String
    expect(item[:description]).to be_a String
  end

  it "returns a single item based on id" do
    item_id = create(:item).id

    get "/api/v1/items/#{item_id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(item[:id]).to eq(item_id)
  end

  it "can find a item by their id" do
    create_list(:item, 5)
    item1 = create(:item)
    item2 = create(:item)

    get "/api/v1/items/find?id=#{item1.id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(item[:id]).to eq(item1.id)
    expect(item[:id]).to_not eq(item2.id)

  end

  it "can find a item by their name" do
    item1 = create(:item)
    item2 = create(:item)
    get "/api/v1/items/find?name=#{item1.name}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(item[:name]).to eq(item1.name)
    expect(item[:name]).to_not eq(item2.name)

  end

  it "can find a item by their description" do
    item1 = create(:item)
    item2 = create(:item)

    get "/api/v1/items/find?description=#{item1.description}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(item[:description]).to eq(item1.description)
    expect(item[:description]).to_not eq(item2.description)

  end

  it "can find a item by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    item1 = create(:item, created_at: timestamp)
    item2 = create(:item)

    get "/api/v1/items/find?created_at=#{item1.created_at}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/items/find?created_at=#{timestamp}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item[:id]).to eq(item1.id)
    expect(item[:id]).to_not eq(item2.id)

  end

  it "can find a item by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    item1 = create(:item, updated_at: timestamp)
    item2 = create(:item)

    get "/api/v1/items/find?updated_at=#{item1.updated_at}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/items/find?updated_at=#{timestamp}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item[:id]).to eq(item1.id)
    expect(item[:id]).to_not eq(item2.id)

  end

  it "can find all items by id" do
    create_list(:item, 5)

    get "/api/v1/items/find_all?id=#{Item.last.id}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item.count).to eq(1)
    expect(item.first[:id]).to eq(Item.last.id)
  end

  it "can find all items by name" do
    create_list(:item, 3, name: "Beavis")

    get "/api/v1/items/find_all?name=Beavis"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item.count).to eq(3)
  end

  it "can find all items by description" do
    create_list(:item, 3, description: "Beavis")

    get "/api/v1/items/find_all?description=Beavis"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item.count).to eq(3)
  end


  it "can find all items by created_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:item, 3, created_at: timestamp)

    get "/api/v1/items/find_all?created_at=#{timestamp}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item.count).to eq(3)
  end

  it "can find all items by updated_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:item, 5)
    create_list(:item, 3, updated_at: timestamp)

    get "/api/v1/items/find_all?updated_at=#{timestamp}"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item.count).to eq(3)
  end

  it "can return a random item" do
    create_list(:item, 5)

    get "/api/v1/items/random"
    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(item[:id]).to be_a(Integer)
    expect(item[:name]).to be_a(String)
    expect(item[:description]).to be_a(String)
  end


end
