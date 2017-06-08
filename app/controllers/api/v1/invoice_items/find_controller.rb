class Api::V1::InvoiceItems::FindController < ApplicationController
  def index
    render json: InvoiceItem.where(strong_params)
  end

  def show
    render json: InvoiceItem.find_by(strong_params)
  end

  private

  def strong_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end
end
