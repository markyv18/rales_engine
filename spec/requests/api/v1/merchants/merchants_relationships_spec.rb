require 'rails_helper'

# GET /api/v1/merchants/revenue?date=x
# GET /api/v1/merchants/most_revenue?quantity=x
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

  it "BI customer endpoint - can find a merchant's fav customer per # of success transactions" do
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)

    invoice1 = create_list(:invoice, 1, customer: customer1, merchant: merchant)
    invoice2 = create_list(:invoice, 1, customer: customer2, merchant: merchant)
    invoice3 = create_list(:invoice, 2, customer: customer3, merchant: merchant)

    invoices = Invoice.all

    invoices.each do |invoice|
     create(:transaction, invoice: invoice, result: "success")
    end

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    fav_customer = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(fav_customer[:id]).to eq(customer3.id)
  end

  it "BI customer endpoint - can find a merchant's customers who have pending invoices" do
    merchant = create(:merchant)
    customer1 = create(:customer)
    customer2 = create(:customer)
    customer3 = create(:customer)

    invoice1 = create_list(:invoice, 5, customer: customer1, merchant: merchant, status: "pending")
    invoice2 = create_list(:invoice, 5, customer: customer2, merchant: merchant, status: "pending")
    invoice3 = create_list(:invoice, 5, customer: customer3, merchant: merchant, status: "ordered")

    get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

    pending_customers = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(pending_customers.first[:id]).to eq(customer1.id)
    expect(pending_customers.second[:id]).to eq(customer2.id)

  end

end

















#
