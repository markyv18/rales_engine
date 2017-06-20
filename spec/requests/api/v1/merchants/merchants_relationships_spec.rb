require 'rails_helper'

# GET /api/v1/merchants/revenue?date=x
# GET /api/v1/merchants/most_revenue?quantity=x
# GET /api/v1/merchants/:id/customers_with_pending_invoices
# GET /api/v1/merchants/:id/favorite_customer
# GET /api/v1/merchants/:id/revenue
# GET /api/v1/merchants/:id/revenue?date=x
# GET /api/v1/merchants/most_items?quantity=x


describe "merchants relationships" do

  it "can find all the items that a merchant sells" do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant: merchant)
    create_list(:item, 5)

    get "/api/v1/merchants/#{merchant.id}/items"

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(results.count).to eq(3)

    expect(results.first[:id]).to eq(items.first.id)
    expect(results.second[:id]).to eq(items.second.id)
  end

  it "can find all the invoices for a merchant" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)
    create_list(:invoice, 5)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(results.count).to eq(3)

    expect(results.first[:id]).to eq(invoices.first.id)
    expect(results.second[:id]).to eq(invoices.second.id)
  end
end
