require 'rails_helper'

describe "merchants API" do
  it "returns all merchants" do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body)
    merchant = merchants.first

    expect(merchants.count).to eq(5)
    expect(merchant).to have_key("name")

  end

  it "can return one merchant by that merchants id" do
    merchant_id = create(:merchant).id

    get "/api/v1/merchants/#{merchant_id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(merchant_id)
  end

end
