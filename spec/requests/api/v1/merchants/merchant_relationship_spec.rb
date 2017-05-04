require 'rails_helper'

describe "merchants API" do

  it "returns all merchants" do
    create_list(:merchant, 5)

    get "/api/v1/merchants"

    expect(response).to be_success

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant = merchants.first

    expect(merchants.count).to eq(5)
    expect(merchant).to have_key(:name)

  end
end
