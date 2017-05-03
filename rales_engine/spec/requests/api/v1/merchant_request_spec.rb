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

  it "can return one merchant by that merchants id" do
    merchant_id = create(:merchant).id

    get "/api/v1/merchants/#{merchant_id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchant[:id]).to eq(merchant_id)
  end


  it "can find a merchant by their id" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant1.id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchant[:id]).to eq(merchant1.id)
    expect(merchant[:id]).to_not eq(merchant2.id)

  end

  it "can find a merchant by their name" do

    merchant1 = create(:merchant, name: "fuck off")
    merchant2 = create(:merchant, name: "no!")

    get "/api/v1/merchants/find?name=#{merchant1.name}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(merchant[:name]).to eq(merchant1.name)
    expect(merchant[:name]).to_not eq(merchant2.name)

  end

  it "can find a merchant by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    merchant1 = create(:merchant, created_at: timestamp)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/merchants/find?created_at=#{timestamp}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(merchant[:id]).to eq(merchant1.id)
    expect(merchant[:id]).to_not eq(merchant2.id)

  end

  it "can find a merchant by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    merchant1 = create(:merchant, updated_at: timestamp)
    merchant2 = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/merchants/find?updated_at=#{timestamp}"
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(merchant[:id]).to eq(merchant1.id)
    expect(merchant[:id]).to_not eq(merchant2.id)

  end

end
