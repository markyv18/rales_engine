require 'rails_helper'

describe "invoice_items relationship APIs" do
  it "returns the invoice for a given invoice_item" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice_id: invoice.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item['invoice_id']).to eq(invoice['id'])
  end

    it "returns the item for a given invoice_item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item['item_id']).to eq(item['id'])
  end
end
