require 'rails_helper'

describe "transactions API" do
  it "returns all transactions" do
    create_list(:transaction, 5)

    get "/api/v1/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body, symbolize_names: true)
    transaction = transactions.first

    expect(transactions.count).to eq(5)
    expect(transaction).to have_key(:credit_card)

  end
end
