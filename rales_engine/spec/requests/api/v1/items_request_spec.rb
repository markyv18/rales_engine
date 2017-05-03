require 'rails_helper'

RSpec.describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it "returns the item with the highest quantity sold" do
    item1, item2, item3 = create_list(:item, 3)
    create_list(:invoice_item, 4, item: item1)
    create_list(:invoice_item, 3, item: item2)
    create_list(:invoice_item, 1, item: item3)
    # binding.pry
    get '/api/v1/items/most_items?quantity=1'
    top_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_item.first["id"]).to eq(item1.id)
  end
end
