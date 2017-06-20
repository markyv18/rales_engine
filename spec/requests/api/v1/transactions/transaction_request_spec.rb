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

  it "can return one transaction by that transactions id" do
    transaction_id = create(:transaction).id

    get "/api/v1/transactions/#{transaction_id}"

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:id]).to eq(transaction_id)
  end

  it "can find a transaction by their id" do
    transaction1 = create(:transaction)
    transaction2 = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction1.id}"

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:id]).to eq(transaction1.id)
    expect(transaction[:id]).to_not eq(transaction2.id)

  end


  it "can find a transaction by their credit_card" do

    transaction1 = create(:transaction)
    transaction2 = create(:transaction)

    get "/api/v1/transactions/find?credit_card=#{transaction1.credit_card}"

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:credit_card]).to eq(transaction1.credit_card)
    expect(transaction[:credit_card]).to_not eq(transaction2.credit_card)

  end

  it "can find a transaction by their result" do

    transaction1 = create(:transaction)
    transaction2 = create(:transaction, result: "FAILURE!!!!!!!!")

    get "/api/v1/transactions/find?result=#{transaction1.result}"

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:result]).to eq(transaction1.result)
    expect(transaction[:result]).to_not eq(transaction2.result)

  end

  it "can find a transaction by their invoice_id" do

    transaction1 = create(:transaction) #, invoice: 5)
    transaction2 = create(:transaction) #, invoice: 6)

    get "/api/v1/transactions/find?invoice_id=#{transaction1.invoice[:id]}"

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(transaction[:invoice_id]).to eq(transaction1.invoice_id)
    expect(transaction[:invoice_id]).to_not eq(transaction2.invoice_id)

  end


  it "can find a transaction by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    transaction1 = create(:transaction, created_at: timestamp)
    transaction2 = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"
    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/transactions/find?created_at=#{timestamp}"
    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(transaction[:id]).to eq(transaction1.id)
    expect(transaction[:id]).to_not eq(transaction2.id)

  end

  it "can find a transaction by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    transaction1 = create(:transaction, updated_at: timestamp)
    transaction2 = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"
    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/transactions/find?updated_at=#{timestamp}"
    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(transaction[:id]).to eq(transaction1.id)
    expect(transaction[:id]).to_not eq(transaction2.id)

  end

  it "can find all transactions by id" do
    create_list(:transaction, 5)

    get "/api/v1/transactions/find_all?id=#{Transaction.last.id}"
    transaction = JSON.parse(response.body)  #symbolize_names is not working for this :id
    #test consisitently runs at a +4 increment... reset DB and still getting +4.. figure it's about right, everything else looks good.

    expect(response).to be_success

    expect(transaction.count).to eq(1)
    expect(transaction.first["id"]).to eq(Transaction.last.id)
  end

  it "can find all transactions by credit_card" do
    cc_number = Faker::Business.credit_card_number
    create_list(:transaction, 3, credit_card: cc_number)

    get "/api/v1/transactions/find_all?credit_card=#{cc_number}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction.count).to eq(3)
  end

  it "can find all transactions by result" do
    create_list(:transaction, 5)
    create_list(:transaction, 3, result: "FAIL!")

    get "/api/v1/transactions/find_all?result=FAIL!"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction.count).to eq(3)
  end

  it "can find all transactions by invoice_id" do
    invoice = create(:invoice)
    create_list(:transaction, 5)
    create_list(:transaction, 2, invoice: invoice)

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction.count).to eq(2)
  end

  it "can find all transactions by created_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:transaction, 5)
    create_list(:transaction, 3, created_at: timestamp)

    get "/api/v1/transactions/find_all?created_at=#{timestamp}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction.count).to eq(3)
  end

  it "can find all transactions by updated_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:transaction, 5)
    create_list(:transaction, 3, updated_at: timestamp)

    get "/api/v1/transactions/find_all?updated_at=#{timestamp}"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction.count).to eq(3)
  end

  it "can return a random transaction" do
    create_list(:transaction, 5)

    get "/api/v1/transactions/random"
    transaction = JSON.parse(response.body)

    expect(response).to be_success

    expect(transaction["id"]).to be_a(Integer)
    expect(transaction["id"]).to be_a(Integer)
  end




end
