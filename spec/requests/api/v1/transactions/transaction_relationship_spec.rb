require 'rails_helper'

describe "transactions relationships" do
  it "can find the invoice of a transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:invoice_id]).to eq(invoice[:id])
  end
end
