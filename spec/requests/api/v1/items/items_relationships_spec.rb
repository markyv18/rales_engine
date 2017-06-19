require 'rails_helper'

describe "items relationships" do

it "gets all invoice items linked with an item" do
     item = create(:item)
     create(:invoice_item, item: item)

     get "/api/v1/items/#{item.id}/invoice_items"
     item = JSON.parse(response.body, symbolize_names: true)

     expect(response).to be_success
#this checks out just needs database cleaner to line up id's... they are incrementing lineraly
     expect(item.first[:item_id]).to eq(item.first[:id])
     expect(item.count).to eq(1)
   end

   it "gets the merchant that the items belongs to" do
     merchant = create(:merchant)
     merchant.items << create(:item)
     item = Item.first

     get "/api/v1/items/#{item.id}/merchant"
     merchant = JSON.parse(response.body, symbolize_names: true)

     expect(response).to be_success
     expect(merchant[:id]).to eq(item.merchant_id)
   end

end
