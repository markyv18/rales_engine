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

  context "best day"
    it "returns the item with the date with the most sales" do
      create_date_1 = "2017-03-05T00:00:00.000Z"
      create_date_2 = "2017-02-05T00:00:00.000Z"
      create_date_3 = "2017-01-05T00:00:00.000Z"
      item = create(:item)
      invoice_items = create_list(:invoice_item, 2, quantity: 3,
        item: item, invoice: create(:invoice, created_at: create_date_1)
        )
      invoice_items = create_list(:invoice_item, 2, quantity: 2,
        item: item,
        invoice: create(:invoice, created_at: create_date_2)
      )

      get "/api/v1/items/#{item.id}/best_day"
      binding.pry
      results = JSON.parse(response.body)
      expect(response).to be_success
      expect(results['best_day']).to eq(create_date_1)
      expect(results['best_day']).to_not eq(create_date_2)
  end
end
