class Api::V1::InvoiceItems::FindController < ApplicationController

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def show
    # byebug
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :item_id, :unit_price)
    # {:id => 1}
    # {:merchant_id => 1}
  end
end
