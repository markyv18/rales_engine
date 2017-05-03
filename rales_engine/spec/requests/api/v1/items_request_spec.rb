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

  it "can create a new item" do
    item_params = { name: "Dr Evil", decription: "One Million?"}

    post "/api/v1/items", params: {item: item_params}
    item = Item.last

    expect(response).to be_success
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Jason Voorhees"}

    put "/api/v1/items/#{id}", params: {item: item_params}
    item = Item.find_by(id: id)

    expect(response).to be_success
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Jason Voorhees")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{delete "/api/v1/items/#{item.id}"}.to change(Item, :count).by(-1)

    expect(response).to be_success
    expect(Item.count).to eq(0)
  end

  it "returns the item with the highest quantity sold" do
    item1, item2, item3 = create_list(:item, 3)
    create_list(:invoice_item, 4, item: item1)
    create_list(:invoice_item, 3, item: item2)
    create_list(:invoice_item, 1, item: item3)
    get '/api/v1/items/most_items?quantity=1'
    top_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(top_item.first["id"].to eq(item1.id))
  end
end
