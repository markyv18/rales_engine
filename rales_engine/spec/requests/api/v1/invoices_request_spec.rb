require 'rails_helper'

RSpec.describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by its id" do
    id = create(:invoice).id
    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq(id)
  end

  it "can create a new invoice" do
    invoice_params = { name: "Dr Evil", decription: "One Million?"}

    post "/api/v1/invoices", params: {invoice: invoice_params}
    invoice = Invoice.last

    expect(response).to be_success
    expect(invoice.name).to eq(invoice_params[:name])
  end

  it "can update an existing invoice" do
    id = create(:invoice).id
    previous_name = Invoice.last.name
    invoice_params = { name: "Jason Voorhees"}

    put "/api/v1/invoices/#{id}", params: {invoice: invoice_params}
    invoice = Invoice.find_by(id: id)

    expect(response).to be_success
    expect(invoice.name).to_not eq(previous_name)
    expect(invoice.name).to eq("Jason Voorhees")
  end

  it "can destroy an invoice" do
    invoice = create(:invoice)

    expect(Invoice.count).to eq(1)

    expect{delete "/api/v1/invoices/#{invoice.id}"}.to change(Invoice, :count).by(-1)

    expect(response).to be_success
    # expect(Invoice.find(invoice.id).to raise_error(ActiveRecord::RecordNotFound))
  end
end
