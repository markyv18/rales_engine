require 'rails_helper'


      # GET /api/v1/items/most_revenue?quantity=x
      # GET /api/v1/items/:id/best_day
      # GET /api/v1/items/most_items?quantity=x


describe "invoice_items relationship APIs" do
  it "returns the invoice for a given invoice_item" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:invoice_id]).to eq(invoice[:id])
  end

    it "returns the item for a given invoice_item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(invoice_item[:item_id]).to eq(item[:id])
  end
end
