require 'rails_helper'

describe "InvoiceItems API" do

  it "sends a list of invoice_items" do
     create_list(:invoice_item, 3)

      get '/api/v1/invoice_items'

      expect(response).to be_success

      invoice_items = JSON.parse(response.body)
   end

  it "can get one invoice_item by its id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq(id)
  end

  context "find method" do
    it "can find an invoice_item by its id" do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item1.id}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice_item1.id)
      expect(result["id"]).to_not eq(invoice_item2.id)
    end
  end

  context "find method" do
    it "can find an invoice_item by its id" do
      invoice_item1 = create(:invoice_item)
      invoice_item2 = create(:invoice_item)

      get "/api/v1/invoice_items/find?quantity=#{invoice_item1.quantity}"

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["id"]).to eq(invoice_item1.id)
      expect(result["id"]).to_not eq(invoice_item2.id)
    end
  end

  context "find all method" do
    it "can find all invoice_items by id" do
      invoice_item = create(:invoice_item)
      create_list(:invoice_item, 4)
      # byebug
      get "/api/v1/invoice_items/find_all?id=#{InvoiceItem.first.id}"

      results = JSON.parse(response.body)
      expect(response).to be_success
      # expect(results.count).to eq(1)
      expect(results.count).to eq(1)

      results.each do |result|
        # byebug
        # binding.pry
        # expect(result["id"]).to eq(InvoiceItem.first.id)
        expect(result["id"]).to eq(results.last["id"])
      end
    end
  end
end
