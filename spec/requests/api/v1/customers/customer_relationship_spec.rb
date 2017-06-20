require 'rails_helper'

describe "customers API" do
  it "finds all the invoices for a particular customer" do
    customer1 = create(:customer, id: 1)
    customer2 = create(:customer, id: 2)
    invoice1 = create_list(:invoice, 2, customer: customer1)
    invoice2 = create_list(:invoice, 2, customer: customer2)

    get "/api/v1/customers/1/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq(2)
    expect(invoices.first[:id]).to eq(invoice1.first[:id])
  end

  it "finds all the transactions for a particular customer" do
      customer = create(:customer)
      invoice = create(:invoice, customer: customer)
      transaction1 = create(:transaction, invoice: invoice)
      transaction2 = create(:transaction, invoice: invoice)
      transaction3 = create(:transaction, invoice: invoice)
      create_list(:transaction, 4)

      get "/api/v1/customers/#{customer.id}/transactions"

      results = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(results.count).to eq(3)

      expect(results.first[:id]).to eq(transaction1.id)
      expect(results.second[:id]).to eq(transaction2.id)
      expect(results.third[:id]).to eq(transaction3.id)
    end


end
