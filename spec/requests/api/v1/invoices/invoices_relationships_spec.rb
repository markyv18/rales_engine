require 'rails_helper'

describe "invoices relationship APIs" do

  it "can find the customer associated with an invoice" do
    customers = create_list(:customer, 3)
    invoice = create(:invoice, customer: customers.first)

    get "/api/v1/invoices/#{invoice.id}/customer"

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(results[:id]).to eq(customers.first.id)
  end

  it "can find the merchant associated with an invoice" do
    merchants = create_list(:merchant, 3)
    invoice = create(:invoice, merchant: merchants.first)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(results[:id]).to eq(merchants.first.id)
  end

  it "can find all transactions for a given invoice " do
    invoice1 = create(:invoice)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice1)
    transaction3 = create(:transaction, invoice: invoice1)
    transaction4 = create(:transaction)

    get "/api/v1/invoices/#{invoice1.id}/transactions"

    results = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(results.count).to eq(3)
    expect(results.first[:id]).to eq(transaction1.id)
    expect(results.second[:id]).to eq(transaction2.id)
    expect(results.third[:id]).to_not eq(transaction4.id)
  end

end
