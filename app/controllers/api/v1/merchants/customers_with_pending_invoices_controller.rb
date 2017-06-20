class Api::V1::Merchants::CustomersWithPendingInvoicesController < ApplicationController
  def show
    render json: Customer.with_pending_invoice(params[:merchant_id].to_i)
  end
end
