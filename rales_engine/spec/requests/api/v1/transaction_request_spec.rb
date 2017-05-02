require 'rails_helper'

describe "transactions API" do
  it "returns all transactions" do
    create_list(:transaction, 5)

    get "/api/v1/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    transaction = transactions.first

    expect(transactions.count).to eq(5)
    expect(transaction).to have_key("credit_card")

  end

  it "can return one transaction by that transactions id" do
    transaction_id = create(:transaction).id

    get "/api/v1/transactions/#{transaction_id}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(transaction["id"]).to eq(transaction_id)
  end

end
