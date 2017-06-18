require 'rails_helper'

describe "invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 5)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)
    invoice = invoices.first

    expect(invoices.count).to eq(5)
    expect(invoice[:name]).to be_a String
    expect(invoice[:description]).to be_a String
  end

  it "returns a single invoice based on id" do
    invoice_id = create(:invoice).id

    get "/api/v1/invoices/#{invoice_id}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice[:id]).to eq(invoice_id)
  end

  it "can find a invoice by their id" do
    create_list(:invoice, 5)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice1.id}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice[:id]).to eq(invoice1.id)
    expect(invoice[:id]).to_not eq(invoice2.id)

  end

  it "can find a invoice by its name" do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    get "/api/v1/invoices/find?name=#{invoice1.name}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice[:name]).to eq(invoice1.name)
    expect(invoice[:name]).to_not eq(invoice2.name)

  end

  it "can find a invoice by its description" do
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)

    get "/api/v1/invoices/find?description=#{invoice1.description}"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice[:description]).to eq(invoice1.description)
    expect(invoice[:description]).to_not eq(invoice2.description)

  end

  it "can find a invoice by their created_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    invoice1 = create(:invoice, created_at: timestamp)
    invoice2 = create(:invoice)

    get "/api/v1/invoices/find?created_at=#{invoice1.created_at}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/invoices/find?created_at=#{timestamp}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice[:id]).to eq(invoice1.id)
    expect(invoice[:id]).to_not eq(invoice2.id)

  end

  it "can find a invoice by their updated_at stamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    invoice1 = create(:invoice, updated_at: timestamp)
    invoice2 = create(:invoice)

    get "/api/v1/invoices/find?updated_at=#{invoice1.updated_at}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    get "/api/v1/invoices/find?updated_at=#{timestamp}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice[:id]).to eq(invoice1.id)
    expect(invoice[:id]).to_not eq(invoice2.id)

  end

  it "can find all invoices by id" do
    create_list(:invoice, 5)

    get "/api/v1/invoices/find_all?id=#{Invoice.last.id}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice.count).to eq(1)
    expect(invoice.first[:id]).to eq(Invoice.last.id)
  end

  it "can find all invoices by name" do
    create_list(:invoice, 3, name: "Beavis")

    get "/api/v1/invoices/find_all?name=Beavis"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice.count).to eq(3)
  end

  it "can find all invoices by description" do
    create_list(:invoice, 3, description: "Beavis")

    get "/api/v1/invoices/find_all?description=Beavis"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice.count).to eq(3)
  end


  it "can find all invoices by created_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:invoice, 3, created_at: timestamp)

    get "/api/v1/invoices/find_all?created_at=#{timestamp}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice.count).to eq(3)
  end

  it "can find all invoices by updated_at timestamp" do
    timestamp = "2017-01-01T00:00:00.000Z"
    create_list(:invoice, 5)
    create_list(:invoice, 3, updated_at: timestamp)

    get "/api/v1/invoices/find_all?updated_at=#{timestamp}"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice.count).to eq(3)
  end

  it "can return a random invoice" do
    create_list(:invoice, 5)

    get "/api/v1/invoices/random"
    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success

    expect(invoice[:id]).to be_a(Integer)
    expect(invoice[:name]).to be_a(String)
    expect(invoice[:description]).to be_a(String)
  end


end
