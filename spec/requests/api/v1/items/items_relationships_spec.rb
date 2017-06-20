require 'rails_helper'

describe "items relationships" do

it "gets all invoice items linked with an item - TEST WORKS WHEN YOU PRY IN" do
     item1 = create(:item)
     create(:invoice_item, item: item1)

     get "/api/v1/items/#{item1.id}/invoice_items"
     item_api = JSON.parse(response.body, symbolize_names: true)

     expect(response).to be_success
     expect(item_api.first[:id]).to eq(item1[:id])
     expect(item_api.count).to eq(1)
     #sometimes this does a 49 v 50 BS.... random, can't pin it down as to what causes it
     #changing variable names will trick it for a little bit then back to 49 v 50
     #can pry in and equate the two aginst each other and it works. weeeird
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
